package com.qunxin.cloundapp

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.provider.Settings
import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import android.os.Build
//import android.support.annotation.RequiresApi
import android.util.Log
import android.widget.Toast
import android.location.Criteria
import android.os.Handler


import java.util.ArrayList
import android.location.LocationListener


import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        init()
        openMarket()

        openSettings()


    }


    override fun onPause() {
        Log.d(TAG, "OnPause")
        super.onPause()
        close()
    }


    private fun init() {
        locationManager = applicationContext.getSystemService(Context.LOCATION_SERVICE) as LocationManager
    }

    private fun openMarket() {
        MethodChannel(flutterView, "samples.chenhang/utils").setMethodCallHandler { methodCall, result ->
            //判断方法名是否支持
            if (methodCall.method == "openAppMarket") {
                try {
                    //应用市场URI
                    val uri = Uri.parse("market://details?id=com.hangchen.example.flutter_module_page.host")
                    val intent = Intent(Intent.ACTION_VIEW, uri)
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    //打开应用市场
                    startActivity(intent)
                    //返回处理结果
                    result.success(0)
                } catch (e: Exception) {
                    //打开应用市场出现异常
                    result.error("UNAVAILABLE", "没有安装应用市场", null)
                }

            } else {
                //方法名暂不支持
                result.notImplemented()
            }
        }
    }

    private fun openSettings() {
        MethodChannel(flutterView, "cloundapp/plugin").setMethodCallHandler { methodCall, result ->
            //判断方法名是否支持
            if (methodCall.method == "openSettings") {
                try {
                    //打开应用市场
                    val intent = Intent(Settings.ACTION_SETTINGS);
                    startActivity(intent)
                    //返回处理结果
                    result.success(0)
                } catch (e: Exception) {
                    //打开应用市场出现异常
                    result.error("UNAVAILABLE", "不能打开设置面板", null)
                }

            } else if (methodCall.method == "getJingwei") {
                try {


                    result.success(getLocation())

                } catch (e: Exception) {
                    //打开应用市场出现异常
                    result.error("UNAVAILABLE", "不能打开设置面板", null)
                }

            } else if (methodCall.method == "close") {
                try {

                    close()

                    result.success(0)

                } catch (e: Exception) {
                    //打开应用市场出现异常
                    result.error("UNAVAILABLE", "不能打开设置面板", null)
                }

            } else {
                //方法名暂不支持
                result.notImplemented()
            }
        }
    }


    /**
     *
     * 定位：得到位置对象
     *
     * @return
     */

    private//获取地理位置管理器
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            // Found best last known location: %s", l);
    val lastKnownLocation: Location?
        get() {

//      val mLocationManager = applicationContext.getSystemService(Context.LOCATION_SERVICE) as LocationManager

            val providers = locationManager!!.getProviders(true)

            var bestLocation: Location? = null

            for (provider in providers) {
                Log.d(TAG, provider.toString())

                if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) !== PackageManager.PERMISSION_GRANTED && checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) !== PackageManager.PERMISSION_GRANTED) {
                    return bestLocation
                }
                locationManager!!.requestLocationUpdates(provider, 0, 0f, locationListener)

                val l = locationManager!!.getLastKnownLocation(provider) ?: continue

                if (bestLocation == null || l.accuracy < bestLocation.accuracy) {

                    bestLocation = l
                    Log.d(TAG, "${provider}   ---------------------------")

                }

            }

            return bestLocation

        }

    //入口是getLocation


    /**
     *
     * 定位：权限判断
     *
     */

    private fun getLocation(): String {

        //检查定位权限

        val permissions = ArrayList<String>()

        if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {

            permissions.add(Manifest.permission.ACCESS_FINE_LOCATION)


        }

        if (checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {

            permissions.add(Manifest.permission.ACCESS_COARSE_LOCATION)

        }


        //判断

        if (permissions.size == 0) {//有权限，直接获取定位

            return getLocationLL()

        } else {//没有权限，获取定位权限

            requestPermissions(permissions.toTypedArray(), 2)


            Log.d(TAG, "*************没有定位权限")
            return ""

        }

    }


    /**
     *
     * 定位：获取经纬度
     *
     */

    private fun getLocationLL(): String {
        Log.d(TAG, "*************获取定位权限1 - 开始")
        val location = lastKnownLocation
//      val location=getLocationFun()
        if (location != null) {

            //传递经纬度给网页

            //            String result = "{code: '0',type:'2',data: {longitude: '" + location.getLongitude() + "',latitude: '" + location.getLatitude() + "'}}";
            //
            //            wvShow.loadUrl("javascript:callback(" + result + ");");


            //日志

            val locationStr = ("维度：" + location.latitude + "\n"

                    + "经度：" + location.longitude)

            Log.d(TAG, "经纬度：" + locationStr)

            var longitude = location.longitude.toDouble()
            var latitude = location.latitude.toDouble()
            val gcj02Pt = gcj02Encrypt(latitude, longitude)
            val result = bd09Encrypt(gcj02Pt[0].toDouble(), gcj02Pt[1].toDouble())
            return "${result[1]},${result[0]}"
//        return "${location.longitude},${location.latitude}"


        } else {

            Toast.makeText(this, "位置信息获取失败", Toast.LENGTH_SHORT).show()


            Log.d(TAG, "获取定位权限7 - " + "位置获取失败")
            return ""

        }

    }


    /**
     *
     * 定位：权限监听
     *
     * @param requestCode
     *
     * @param permissions
     *
     * @param grantResults
     */

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {

        when (requestCode) {

            2//定位
            ->

                if (grantResults.size > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {


                    Log.d(TAG, "*************同意定位权限")

                    getLocationLL()

                } else {

                    Toast.makeText(this, "未同意获取定位权限", Toast.LENGTH_SHORT).show()

                }
        }

    }

    private var locationManager: LocationManager? = null
    private fun getLocationFun(): Location? {
//        var locationManager = applicationContext.getSystemService(Context.LOCATION_SERVICE) as LocationManager
//        close()

        val criteria = Criteria()
        criteria.setAccuracy(Criteria.ACCURACY_COARSE)//低精度，如果设置为高精度，依然获取不了location。
        criteria.setAltitudeRequired(false)//不要求海拔
        criteria.setBearingRequired(false)//不要求方位
        criteria.setCostAllowed(true)//允许有花费
        criteria.setPowerRequirement(Criteria.POWER_LOW)//低功耗
        val locationProvider = locationManager!!.getBestProvider(criteria, true)
        if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) !== PackageManager.PERMISSION_GRANTED && checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) !== PackageManager.PERMISSION_GRANTED) {
            return null
        }
        val location = locationManager!!.getLastKnownLocation(locationProvider)
//        val location = locationManager!!.getLastKnownLocation(LocationManager.GPS_PROVIDER)
        Log.d(TAG, "onCreate: " + (location == null) + "..")
//        Log.d(TAG, "onCreate: " + locationProvider)

        if (location != null) {
            Log.d(TAG, "onCreate: location")
            //不为空,显示地理位置经纬度
            showLocation(location)
            return location
        }
        locationManager!!.requestLocationUpdates(locationProvider, 0, 0f, locationListener)
//        locationManager!!.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0f, locationListener)
        return null
    }

    private fun showLocation(location: Location) {
        Log.d(TAG, "定位成功------->" + "location------>经度为：" + location.getLatitude() + "\n纬度为" + location.getLongitude())
    }

    /**
     * LocationListern监听器
     * 参数：地理位置提供器、监听位置变化的时间间隔、位置变化的距离间隔、LocationListener监听器
     */

    internal var locationListener: LocationListener? = object : LocationListener {

        override fun onStatusChanged(provider: String, status: Int, arg2: Bundle) {
            Log.d(TAG, "onStatusChanged: " + provider + ".." + Thread.currentThread().name)

        }

        override fun onProviderEnabled(provider: String) {
            Log.d(TAG, "onProviderEnabled: " + provider + ".." + Thread.currentThread().name)
        }

        override fun onProviderDisabled(provider: String) {
            Log.d(TAG, "onProviderDisabled: " + provider + ".." + Thread.currentThread().name)
        }

        override fun onLocationChanged(location: Location) {
            Log.d(TAG, "onLocationChanged: " + ".." + Thread.currentThread().name)
            //如果位置发生变化,重新显示
            showLocation(location)
        }
    }

    private fun close() {
        Log.d(TAG, "close")
        locationManager!!.removeUpdates(locationListener);

    }


    companion object {
        private val TAG = "LocationActivity"
    }

    var jzA = 6378245.0
    var jzEE = 0.00669342162296594323
    var pi = 3.14159265358979324

    fun transformLat(x: Double, y: Double): Double {
        var ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.sqrt(Math.abs(x))
        ret += (20.0 * Math.sin(6.0 * x * pi) + 20.0 * Math.sin(2.0 * x * pi)) * 2.0 / 3.0
        ret += (20.0 * Math.sin(y * pi) + 40.0 * Math.sin(y / 3.0 * pi)) * 2.0 / 3.0
        ret += (160.0 * Math.sin(y / 12.0 * pi) + 320 * Math.sin(y * pi / 30.0)) * 2.0 / 3.0
        return ret
    }

    fun transformLon(x: Double, y: Double): Double {
        var ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.sqrt(Math.abs(x))
        ret += (20.0 * Math.sin(6.0 * x * pi) + 20.0 * Math.sin(2.0 * x * pi)) * 2.0 / 3.0
        ret += (20.0 * Math.sin(x * pi) + 40.0 * Math.sin(x / 3.0 * pi)) * 2.0 / 3.0
        ret += (150.0 * Math.sin(x / 12.0 * pi) + 300.0 * Math.sin(x / 30.0 * pi)) * 2.0 / 3.0
        return ret
    }


    fun gcj02Encrypt(ggLat: Double, ggLon: Double): FloatArray {
        val resPoint = FloatArray(2)
        val mgLat: Double
        val mgLon: Double
        var dLat = transformLat(ggLon - 105.0, ggLat - 35.0)
        var dLon = transformLon(ggLon - 105.0, ggLat - 35.0)
        val radLat = ggLat / 180.0 * Math.PI
        var magic = Math.sin(radLat)
        magic = 1 - jzEE * magic * magic
        val sqrtMagic = Math.sqrt(magic)
        dLat = dLat * 180.0 / (jzA * (1 - jzEE) / (magic * sqrtMagic) * Math.PI)
        dLon = dLon * 180.0 / (jzA / sqrtMagic * Math.cos(radLat) * Math.PI)
        mgLat = ggLat + dLat
        mgLon = ggLon + dLon

        resPoint[0] = mgLat.toFloat()
        resPoint[1] = mgLon.toFloat()
        return resPoint
    }

    // 传入中国国测局地理的坐标
    fun bd09Encrypt(ggLat: Double, ggLon: Double): FloatArray {
        val bdPt = FloatArray(2)
        val x: Double = ggLon
        val y: Double = ggLat
        val z = Math.sqrt(x * x + y * y) + 0.00002 * Math.sin(y * Math.PI)
        val theta = Math.atan2(y, x) + 0.000003 * Math.cos(x * Math.PI)
        bdPt[1] = (z * Math.cos(theta) + 0.0065).toFloat()
        bdPt[0] = (z * Math.sin(theta) + 0.0065).toFloat()
        return bdPt
    }
}

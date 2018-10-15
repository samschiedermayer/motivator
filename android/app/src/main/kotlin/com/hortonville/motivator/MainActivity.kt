package com.hortonville.motivator

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.TaskStackBuilder
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.support.v4.app.NotificationCompat
import android.util.Log

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity() : FlutterActivity() {

    var TAG = "MAINACTIVITY"
    var CHANNEL = "flutter.hortonville.com.channel"
    var NOTIFICATION_CHANNEL = "Notifications"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        createNotificationChannel()
        
        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            // manage method calls here

            if(call.method=="scheduleNotification") {
                showDoneNotification(call.argument("goal"))
            }

        }

    }

    private fun createNotificationChannel() {
        // Create the NotificationChannel, but only on API 26+ because
        // the NotificationChannel class is new and not in the support library
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = NOTIFICATION_CHANNEL
            val description = "Gives you encouraging messages"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(NOTIFICATION_CHANNEL, name, importance)
            channel.description = description
            channel.lightColor = Color.GREEN
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }

    fun showDoneNotification(goal: String) {
        val notificationManager = this.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager


        val resultIntent = Intent(this, this::class.java)


        val stackBuilder = TaskStackBuilder.create(this)
        stackBuilder.addNextIntentWithParentStack(resultIntent)

        val previewImageIntent = stackBuilder.getPendingIntent(0, PendingIntent.FLAG_UPDATE_CURRENT)


        val builder = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL)
                .setContentTitle("Motivator")
                .setAutoCancel(true)
                .setContentText("Do you want to $goal? Well you can! Believe in yourself!")
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                .setContentIntent(previewImageIntent)


        try {
            notificationManager.notify(1, builder.build())
        } catch (npe: NullPointerException) {
            Log.e("showDoneNotification", "Failed to create notification")
            npe.printStackTrace()
        }

    }

}

import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Time.Gregorian;

class BitFaceView extends WatchUi.WatchFace {
    private var timeFont;
    private var dataFont;
    private var dateFont;
    private var stepsIcon;
    private var heartIcon;

    function initialize() {
        WatchFace.initialize();
        timeFont = Application.loadResource(Rez.Fonts.TimeFont);
        dataFont = Application.loadResource(Rez.Fonts.DataFont);
        dateFont = Application.loadResource(Rez.Fonts.DateFont);
        stepsIcon = Application.loadResource(Rez.Drawables.StepsIcon);
        heartIcon = Application.loadResource(Rez.Drawables.HeartIcon);
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onShow() as Void {
    }

    function onUpdate(dc) {
      View.onUpdate(dc);
      drawTime(dc);
      drawHR(dc);
      drawSteps(dc);
      drawDate(dc);
    }

    function drawTime(dc) {
      var timeFormat = "$1$:$2$";
      var clockTime = System.getClockTime();
      var hours = clockTime.hour;
      if (!System.getDeviceSettings().is24Hour) {
        if (hours > 12) {
          hours -= 12;
        }
      } else {
          if (getApp().getProperty("UseMilitaryFormat")) {
              timeFormat = "$1$$2$";
              hours = hours.format("%02d");
          }
      }
      var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

      dc.drawText(
        dc.getWidth() / 2,
        dc.getHeight() / 2 + 16,
        timeFont,
        timeString,
        Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER 
      );
    }

    function drawHR(dc) {
      
      var heartRate = retrieveHeartrateText();

      var dataWidth = dc.getTextWidthInPixels(heartRate, dataFont) + 40;
      var x = dc.getWidth() / 2 - dataWidth / 2;

      dc.drawBitmap(
        x,
        20,
        heartIcon
      );

      dc.drawText(
        x + 40,
        18,
        dataFont,
        heartRate,
        Graphics.TEXT_JUSTIFY_LEFT
      );
    }

    private function retrieveHeartrateText() {
      var info = Activity.getActivityInfo();

      if (info != null) {
        var hr = info.currentHeartRate;
        if (hr == null) {
          return "--";
        }
        return Lang.format("$1$", [hr]);
      }


      var hrIterator = ActivityMonitor.getHeartRateHistory(null, false);

      var sample = hrIterator.next();
      if (sample == null) {
        return "--";
      }
      if (sample.heartRate == ActivityMonitor.INVALID_HR_SAMPLE) {
        return "--";
      }
      
      return Lang.format("$1$", [sample.heartRate]);

      /*
      var heartRate = null;
      var info = Activity.getActivityInfo();

      if (info != null) {
        heartRate = info.currentHeartRate;
      } else {
        var latestHeartRateSample = ActivityMonitor.getHeartRateHistory(1, true).next();
        if (latestHeartRateSample != null) {
          heartRate = latestHeartRateSample.heartRate;
        }
      }
      if (heartRate == null) {
        return "--";
      }
      return Lang.format("$1$", [heartRate]);
      */
    } 

    function drawSteps(dc) {
      var stepCount = ActivityMonitor.getInfo().steps.toString();
      var dataWidth = dc.getTextWidthInPixels(stepCount, dataFont) + 40;
      var x = dc.getWidth() / 2 - dataWidth / 2;

      dc.drawBitmap(
        x,
        dc.getHeight() - 60,
        stepsIcon
      );

      dc.drawText(
        x + 40,
        dc.getHeight() -60,
        dataFont,
        stepCount,
        Graphics.TEXT_JUSTIFY_LEFT
      );
    }

    function drawDate(dc) {
      var now = Time.now();
      var date = Gregorian.info(now, Time.FORMAT_MEDIUM);
      var dateString = Lang.format("$1$, $2$ $3$", [date.day_of_week, date.month, date.day]);

      dc.drawText(
        dc.getWidth() / 2,
        60,
        dateFont,
        dateString,
        Graphics.TEXT_JUSTIFY_CENTER
      );
    }

    function onHide() as Void {
    }

    function onExitSleep() as Void {
    }

    function onEnterSleep() as Void {
    }

}

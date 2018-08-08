from __future__ import absolute_import, unicode_literals
import datetime
import time
import unittest
from stopwatch import stopwatch
import helpers


class MainTests(helpers.TestCase):
    def test_delta_description(self):
        data = [
            (datetime.timedelta(), "00:00:00.000"),
            (datetime.timedelta(0, 1, 123456), "00:00:01.123"),
            (datetime.timedelta(0, 5000, 234567), "01:23:20.234"),
            (datetime.timedelta(1, 3700, 345678), "25:01:40.345"),
        ]

        for entry in data:
            self.assertEqual(stopwatch.delta_formatted(entry[0]), entry[1])


class TimerTests(helpers.TestCase):
    class _TimerTester:
        def __init__(self):
            self.total_time = 0
            self.last_lap_time = 0
            self.lap_count = 0
            self.was_updated = False
            def update(lap, delta_relative, delta_absolute):
                self.was_updated = True
                self.lap_count = lap
                self.total_time = helpers.total_seconds(delta_absolute)
                self.last_lap_time = helpers.total_seconds(delta_relative)
            self.timer = stopwatch.Timer(update)

    def test_timer_basic(self):
        # given
        actual_delay = 0
        tester = self._TimerTester()

        # when
        tester.timer.start()
        actual_delay = helpers.sleep(0.3)
        tester.timer.stop()

        # then
        self.assertTrue(tester.was_updated)
        self.assertEqual(tester.lap_count, 1)
        self.assertAlmostEqual(tester.last_lap_time, actual_delay, delta=0.05)
        self.assertAlmostEqual(tester.total_time, actual_delay, delta=0.05)

    def test_timer_pausing(self):
        # given
        actual_delay = 0
        tester = self._TimerTester()

        # when
        tester.timer.start()
        actual_delay += helpers.sleep(0.3)
        tester.timer.stop()
        time.sleep(0.5)
        tester.timer.start()
        actual_delay += helpers.sleep(0.3)
        tester.timer.stop()

        # then
        self.assertTrue(tester.was_updated)
        self.assertEqual(tester.lap_count, 1)
        self.assertAlmostEqual(tester.last_lap_time, actual_delay, delta=0.05)
        self.assertAlmostEqual(tester.total_time, actual_delay, delta=0.05)

    def test_timer_lapping_simple(self):
        # given
        tester = self._TimerTester()

        # when
        tester.timer.start()
        tester.timer.stop()
        tester.timer.lap()

        # then
        self.assertEqual(tester.lap_count, 2)
        self.assertAlmostEqual(tester.last_lap_time, 0, delta=0.02)
        self.assertAlmostEqual(tester.total_time, 0, delta=0.02)

    def test_timer_lapping_complex(self):
        # given
        actual_delay = []
        tester = self._TimerTester()

        # when
        tester.timer.start()
        actual_delay.append(helpers.sleep(0.3))
        tester.timer.stop()
        tester.timer.lap()
        tester.timer.start()
        actual_delay.append(helpers.sleep(0.3))
        tester.timer.stop()

        # then
        self.assertTrue(tester.was_updated)
        self.assertEqual(tester.lap_count, 2)
        self.assertAlmostEqual(tester.last_lap_time, actual_delay[-1], delta=0.05)
        self.assertAlmostEqual(tester.total_time, sum(actual_delay), delta=0.05)


if __name__ == '__main__':
    unittest.main()

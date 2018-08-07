from __future__ import (
    absolute_import, division, print_function, unicode_literals
)
import datetime
import sys
import time
import unittest
from stopwatch import stopwatch


# sleep for <amount> and return how long actually slept
# because simple time.sleep() is unreliable in spent time, (specifically on CI)
def sleep(amount):
    before = datetime.datetime.now()
    time.sleep(amount)
    after = datetime.datetime.now()
    return (after - before).total_seconds()


def total_seconds(delta):
    return sum([
        delta.days * 24 * 60 * 60,
        delta.seconds,
        delta.microseconds / 1000000,
    ])


class MainTests(unittest.TestCase):
    def test_delta_description(self):
        data = [
            (datetime.timedelta(), "00:00:00.000"),
            (datetime.timedelta(0, 1, 123456), "00:00:01.123"),
            (datetime.timedelta(0, 5000, 234567), "01:23:20.234"),
            (datetime.timedelta(1, 3700, 345678), "25:01:40.345"),
        ]

        for entry in data:
            self.assertEqual(stopwatch.delta_formatted(entry[0]), entry[1])


class TestHelpersTests(unittest.TestCase):
    def test_total_seconds(self):
        data = [
            (datetime.timedelta(), 0),
            (datetime.timedelta(0, 1, 123456), 1.123456),
            (datetime.timedelta(0, 5000, 234567), 5000.234567),
            (datetime.timedelta(1, 3700, 345678), 90100.345678),
        ]

        for entry in data:
            self.assertEqual(total_seconds(entry[0]), entry[1])

    def test_sleep(self):
        self.assertAlmostEqual(sleep(0.1), 0.1, delta=0.3)
        self.assertAlmostEqual(sleep(0.2), 0.2, delta=0.3)
        self.assertAlmostEqual(sleep(0.3), 0.3, delta=0.3)
        self.assertAlmostEqual(sleep(0.4), 0.4, delta=0.3)
        self.assertAlmostEqual(sleep(0.5), 0.5, delta=0.3)
        self.assertAlmostEqual(sleep(0.6), 0.6, delta=0.3)


class TimerTests(unittest.TestCase):
    class TimerTester:
            def __init__(self, *args, **kwargs):
                self.total_time = 0
                self.last_lap_time = 0
                self.lap_count = 0
                self.was_updated = False
                def update(lap, delta_relative, delta_absolute):
                    self.was_updated = True
                    self.lap_count = lap
                    self.total_time = total_seconds(delta_absolute)
                    self.last_lap_time = total_seconds(delta_relative)
                self.timer = stopwatch.Timer(update)

    def __init__(self, *args, **kwargs):
        super(TimerTests, self).__init__(*args, **kwargs)
        if sys.version_info < (2, 7):
            def assert_almost_equal(self, first, second, delta):
                self.assertTrue(self, first + delta >= second)
                self.assertTrue(self, first - delta <= second)
            TimerTests.assertAlmostEqual = assert_almost_equal

    def test_timer_basic(self):
        # given
        actual_delay = 0
        tester = self.TimerTester()

        # when
        tester.timer.start()
        actual_delay = sleep(0.3)
        tester.timer.stop()

        # then
        self.assertTrue(tester.was_updated)
        self.assertEqual(tester.lap_count, 1)
        self.assertAlmostEqual(tester.last_lap_time, actual_delay, delta=0.01)
        self.assertAlmostEqual(tester.total_time, actual_delay, delta=0.01)

    def test_timer_pausing(self):
        # given
        actual_delay = 0
        tester = self.TimerTester()

        # when
        tester.timer.start()
        actual_delay += sleep(0.3)
        tester.timer.stop()
        time.sleep(0.5)
        tester.timer.start()
        actual_delay += sleep(0.3)
        tester.timer.stop()

        # then
        self.assertTrue(tester.was_updated)
        self.assertEqual(tester.lap_count, 1)
        self.assertAlmostEqual(tester.last_lap_time, actual_delay, delta=0.01)
        self.assertAlmostEqual(tester.total_time, actual_delay, delta=0.01)

    def test_timer_lapping_simple(self):
        # given
        tester = self.TimerTester()

        # when
        tester.timer.start()
        tester.timer.stop()
        tester.timer.lap()

        # then
        self.assertEqual(tester.lap_count, 2)
        self.assertAlmostEqual(tester.last_lap_time, 0, delta=0.01)
        self.assertAlmostEqual(tester.total_time, 0, delta=0.01)

    def test_timer_lapping_complex(self):
        # given
        actual_delay = []
        tester = self.TimerTester()

        # when
        tester.timer.start()
        actual_delay.append(sleep(0.3))
        tester.timer.stop()
        tester.timer.lap()
        tester.timer.start()
        actual_delay.append(sleep(0.3))
        tester.timer.stop()

        # then
        self.assertTrue(tester.was_updated)
        self.assertEqual(tester.lap_count, 2)
        self.assertAlmostEqual(tester.last_lap_time, actual_delay[-1], delta=0.01)
        self.assertAlmostEqual(tester.total_time, sum(actual_delay), delta=0.01)


if __name__ == '__main__':
    unittest.main()

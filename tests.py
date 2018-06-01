from __future__ import (
    absolute_import, division, print_function, unicode_literals
)
import datetime
import sys
import time
import unittest
from stopwatch import stopwatch


class MainTests(unittest.TestCase):
    def test_delta_description(self):
        data = [
            (datetime.timedelta(), "00:00:00.000"),
            (datetime.timedelta(0, 1, 123456), "00:00:01.123"),
            (datetime.timedelta(0, 5000, 123456), "01:23:20.123"),
            (datetime.timedelta(1, 3700, 123456), "25:01:40.123"),
        ]

        for entry in data:
            self.assertEqual(stopwatch.delta_formatted(entry[0]), entry[1])


class TimerTests(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super(TimerTests, self).__init__(*args, **kwargs)
        if sys.version_info < (2, 7):
            def assert_almost_equal(self, first, second, delta):
                self.assertTrue(self, first + delta >= second)
                self.assertTrue(self, first - delta <= second)
            TimerTests.assertAlmostEqual = assert_almost_equal

    def test_timer_basic(self):
        def operations(timer):
            timer.start()
            time.sleep(0.2)
            timer.stop()

        data = timer_execute(operations)

        self.assertEqual(data['lap'], 1)
        self.assertAlmostEqual(data['time_relative'], 0.2, delta=0.15)
        self.assertAlmostEqual(data['time_absolute'], 0.2, delta=0.15)

    def test_timer_pausing(self):
        def operations(timer):
            timer.start()
            time.sleep(0.2)
            timer.stop()
            time.sleep(0.2)
            timer.start()
            time.sleep(0.2)
            timer.stop()

        data = timer_execute(operations)

        self.assertEqual(data['lap'], 1)
        self.assertAlmostEqual(data['time_relative'], 0.4, delta=0.15)
        self.assertAlmostEqual(data['time_absolute'], 0.4, delta=0.15)

    def test_timer_lapping_simple(self):
        def operations(timer):
            timer.start()
            timer.stop()
            timer.lap()

        data = timer_execute(operations)

        self.assertEqual(data['lap'], 2)
        self.assertAlmostEqual(data['time_relative'], 0, delta=0.02)
        self.assertAlmostEqual(data['time_absolute'], 0, delta=0.02)

    def test_timer_lapping_complex(self):
        def operations(timer):
            timer.start()
            time.sleep(0.2)
            timer.stop()
            timer.lap()
            timer.start()
            time.sleep(0.2)
            timer.stop()

        data = timer_execute(operations)

        self.assertEqual(data['lap'], 2)
        self.assertAlmostEqual(data['time_relative'], 0.2, delta=0.15)
        self.assertAlmostEqual(data['time_absolute'], 0.4, delta=0.15)


def timer_execute(operations):
    data = {
        'called': False,
        'lap': 0,
        'time_relative': 0.0,
        'time_absolute': 0.0,
    }

    def update(lap, delta_relative, delta_absolute):
        def total_seconds(delta):
            return sum([
                delta.days * 24 * 60 * 60,
                delta.seconds,
                delta.microseconds / 1000000,
            ])
        data['called'] = True
        data['lap'] = lap
        data['time_relative'] = total_seconds(delta_relative)
        data['time_absolute'] = total_seconds(delta_absolute)

    timer = stopwatch.Timer(update)
    operations(timer)
    return data


if __name__ == '__main__':
    unittest.main()

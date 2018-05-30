from __future__ import absolute_import, division, print_function, unicode_literals
import datetime
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

    def _help_test_timer(self, operations):
        data = {
            'called': False,
            'lap': 0,
            'time_relative': 0.0,
            'time_absolute': 0.0,
        }

        def update(lap, delta_relative, delta_absolute):
            data['called'] = True
            data['lap'] = lap
            data['time_relative'] = delta_relative.total_seconds()
            data['time_absolute'] = delta_absolute.total_seconds()

        timer = stopwatch.Timer(update)
        operations(timer)
        return data

    def test_timer_basic(self):
        def operations(timer):
            timer.start()
            time.sleep(0.02)
            timer.stop()

        data = self._help_test_timer(operations)

        self.assertEqual(data['lap'], 1)
        self.assertAlmostEqual(data['time_relative'], 0.02, delta=0.01)
        self.assertAlmostEqual(data['time_absolute'], 0.02, delta=0.01)

    def test_timer_pausing(self):
        def operations(timer):
            timer.start()
            time.sleep(0.01)
            timer.stop()
            time.sleep(0.01)
            timer.start()
            time.sleep(0.01)
            timer.stop()

        data = self._help_test_timer(operations)

        self.assertEqual(data['lap'], 1)
        self.assertAlmostEqual(data['time_relative'], 0.02, delta=0.01)
        self.assertAlmostEqual(data['time_absolute'], 0.02, delta=0.01)

    def test_timer_lapping_simple(self):
        def operations(timer):
            timer.start()
            timer.stop()
            timer.lap()

        data = self._help_test_timer(operations)

        self.assertEqual(data['lap'], 2)
        self.assertAlmostEqual(data['time_relative'], 0, delta=0.002)
        self.assertAlmostEqual(data['time_absolute'], 0, delta=0.002)

    def test_timer_lapping_complex(self):
        def operations(timer):
            timer.start()
            time.sleep(0.01)
            timer.stop()
            timer.lap()
            timer.start()
            time.sleep(0.01)
            timer.stop()

        data = self._help_test_timer(operations)

        self.assertEqual(data['lap'], 2)
        self.assertAlmostEqual(data['time_relative'], 0.01, delta=0.01)
        self.assertAlmostEqual(data['time_absolute'], 0.02, delta=0.01)


if __name__ == '__main__':
    unittest.main()

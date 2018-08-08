from __future__ import absolute_import, unicode_literals
import datetime
import unittest
import helpers


class TestHelpersTests(unittest.TestCase):
    def test_sleep(self):
        self.assertAlmostEqual(helpers.sleep(0.1), 0.1, delta=0.3)
        self.assertAlmostEqual(helpers.sleep(0.2), 0.2, delta=0.3)
        self.assertAlmostEqual(helpers.sleep(0.3), 0.3, delta=0.3)
        self.assertAlmostEqual(helpers.sleep(0.4), 0.4, delta=0.3)
        self.assertAlmostEqual(helpers.sleep(0.5), 0.5, delta=0.3)
        self.assertAlmostEqual(helpers.sleep(0.6), 0.6, delta=0.3)

    def test_total_seconds(self):
        data = [
            (datetime.timedelta(), 0),
            (datetime.timedelta(0, 1, 123456), 1.123456),
            (datetime.timedelta(0, 5000, 234567), 5000.234567),
            (datetime.timedelta(1, 3700, 345678), 90100.345678),
        ]

        for entry in data:
            self.assertEqual(helpers.total_seconds(entry[0]), entry[1])


if __name__ == '__main__':
    unittest.main()

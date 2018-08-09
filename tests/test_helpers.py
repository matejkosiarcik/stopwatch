from __future__ import absolute_import, unicode_literals
import datetime
import unittest
import helpers


class TestHelpersTests(helpers.TestCase):
    def test_sleep(self):
        waited = helpers.sleep(0.4)
        self.assertTrue(waited >= 0.4 and waited < 1.4)

        waited = helpers.sleep(0.6)
        self.assertTrue(waited >= 0.6 and waited < 1.6)

        waited = helpers.sleep(0.8)
        self.assertTrue(waited >= 0.8 and waited < 1.8)

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

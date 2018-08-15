from __future__ import absolute_import, division
import datetime
import sys
import time
import unittest


# Patched TestCase class
# contains missing asserts for python 2.6
class TestCase(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super(TestCase, self).__init__(*args, **kwargs)
        if sys.version_info < (2, 7):
            def assert_almost_equal(self, first, second, delta):
                self.assertTrue(self, first + delta >= second)
                self.assertTrue(self, first - delta <= second)
            TestCase.assertAlmostEqual = assert_almost_equal


# returns total seconds for given datatime.timedelta
def total_seconds(delta):
    return sum([
        delta.days * 24 * 60 * 60,
        delta.seconds,
        delta.microseconds / 1000000,
    ])


# sleep for <amount> and return how long actually slept
# because simple time.sleep() is unreliable in spent time, (specifically on CI)
def sleep(amount):
    before = datetime.datetime.now()
    time.sleep(amount)
    after = datetime.datetime.now()
    return total_seconds(after - before)

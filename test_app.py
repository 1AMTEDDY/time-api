import unittest
from app import app

class APITestCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()

    def test_get_time(self):
        response = self.app.get('/time')
        self.assertEqual(response.status_code, 200)

if __name__ == '__main__':
    unittest.main()

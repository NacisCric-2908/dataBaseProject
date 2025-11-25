from django.test import TestCase, Client
from django.urls import reverse


class HomeViewTests(TestCase):
	def setUp(self):
		self.client = Client()

	def test_home_status_code(self):
		resp = self.client.get(reverse('home'))
		self.assertEqual(resp.status_code, 200)

	def test_home_contains_form_fields(self):
		resp = self.client.get(reverse('home'))
		self.assertContains(resp, 'name="txtCodigo"')
		self.assertContains(resp, 'name="txtNombre"')
		self.assertContains(resp, 'name="txtApellido"')
		self.assertContains(resp, 'name="txtNumDocumento"')
		self.assertContains(resp, 'name="TipoDocumento"')

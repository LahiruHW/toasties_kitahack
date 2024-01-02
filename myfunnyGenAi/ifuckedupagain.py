'''google_api_key'''
# AIzaSyCpVdnrotOWPjFPRXyFNMKj59E9_v8bDKw

from PIL import Image
import io
import base64
import google.generativeai as genai


genai.configure(api_key='AIzaSyCpVdnrotOWPjFPRXyFNMKj59E9_v8bDKw')

model_gemini_pro_vision = genai.GenerativeModel('gemini-pro-vision')

img = Image.open('sex.jpg')
byte_arr=  io.BytesIO()
img.save(byte_arr, format=img.format)
byte_arr = byte_arr.getvalue()
encoded_image_data = base64.b64encode(byte_arr)

image_blob = {
    'mime_type': 'image/jpeg',
    'data': encoded_image_data.decode('utf-8')
}

prompt = """Write a poet about what this person in the photo did as a president"""

response = model_gemini_pro_vision.generate_content([prompt, {'inline_data': image_blob}], stream=True)
for chunk in response:
    print(chunk.text, end="")

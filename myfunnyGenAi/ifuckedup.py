'''google_api_key'''
# AIzaSyCpVdnrotOWPjFPRXyFNMKj59E9_v8bDKw

from configparser import ConfigParser
import google.generativeai as genai 

genai.configure(api_key='AIzaSyCpVdnrotOWPjFPRXyFNMKj59E9_v8bDKw')

model_gemini_pro = genai.GenerativeModel('gemini-pro')

prompt = """
Which countries have the lowest age limits for drinking?"""

response = model_gemini_pro.generate_content(prompt, stream=True)

for chunk in response:
    print(chunk.text)
# print(response.text)
    

    
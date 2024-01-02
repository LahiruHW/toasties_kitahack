from configparser import ConfigParser
import google.generativeai as genai 

# Configure the API key
def initialise():
    genai.configure(api_key='AIzaSyCpVdnrotOWPjFPRXyFNMKj59E9_v8bDKw')

    # Initialize the model
    return genai.GenerativeModel('gemini-pro')

def construct_message(message, role='user'):
    return {'role': role, 'parts': [message]}

def add_model_response(conversation, model):
    response = model.generate_content(conversation)
    response.resolve()
    conversation.append(construct_message(response.text, 'model'))
    print(conversation[-1]['parts'][0])
    print('---'*15)

if __name__ == "__main__":
    model_gemini_pro = initialise()

    conversation = [construct_message('Can you write a 50 word essay on cats?')]

    while True:
        add_model_response(conversation, model_gemini_pro)
        user_input = input("Enter your next message or type 'quit' to end: ")
        print('---'*15)
        if user_input.lower == "quit":
            break
        conversation.append(construct_message(user_input))
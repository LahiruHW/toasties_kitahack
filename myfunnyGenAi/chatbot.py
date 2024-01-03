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

    prompt_start = "Answer this question as the financial lawyer named LAILA:\n\n"

    inital_prompt = """Act like you are a financial lawyer named LAILA (Legally & Artificially Intelligent Lawyer Assistant) who is here to help me with any problems I have with financial law. Can you please give a short introduction of yourself to me?"""

    prompt_end = "\n\nPlease answer this question with the personality of how a good, friendly financial lawyer would with me, ask me for more context if the question doesn't provide enough of it"

    conversation = [construct_message(inital_prompt)]

    while True:
        add_model_response(conversation, model_gemini_pro)
        user_input = input("Enter your next message or type 'quit' to end: ")
        print('---'*15)
        if user_input.lower == "quit":
            break
        prompt = prompt_start + user_input + prompt_end
        conversation.append(construct_message(prompt))
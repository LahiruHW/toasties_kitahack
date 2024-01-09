from flask import Flask, request, jsonify

import google.generativeai as genai 

app = Flask(__name__)


# Configure the API key
def initialise():
#     while True:
#         lawyer_input = input(f"""
# Choose a type of lawyer to interact with:
# a. Criminal Lawyer
# b. Financial Lawyer
# c. Copyright Lawyer
# d. Tax Lawyer
# e. Employment Lawyer
# """)

#         match lawyer_input.lower():
#             case 'a':
#                 lawyer_type = "criminal"
#             case 'b':
#                 lawyer_type = "financial"
#             case 'c':
#                 lawyer_type = "copyright"
#             case 'd':
#                 lawyer_type = "tax"
#             case 'e':
#                 lawyer_type = "employment"
#             case _:
#                 print("Invalid Input")
#                 continue
#         break



    genai.configure(api_key='AIzaSyCpVdnrotOWPjFPRXyFNMKj59E9_v8bDKw')

    # Initialize the model
    return genai.GenerativeModel('gemini-pro')

def construct_message(message, role='user'):
    return {'role': role, 'parts': [message]}

def add_model_response(conversation, model):
    response = model.generate_content(conversation)
    response.resolve()
    conversation.append(construct_message(response.text, 'model'))
    return conversation[-1]['parts'][0]



def response(question):
    lawyer_type, model_gemini_pro = "financial", initialise()

    prompt_start = f"Answer this question as the {lawyer_type} lawyer named LAILA:\n\n"

    inital_prompt = f"Act like you are a {lawyer_type} lawyer named LAILA (Legally & Artificially Intelligent Lawyer Assistant) who is here to help me with any problems I have with {lawyer_type} law. Can you please give a short introduction of yourself to me?"

    prompt_end = f"\n\nPlease answer this question with the personality of how a good, friendly {lawyer_type} lawyer would with me ask me for more context if the question doesn't provide enough of it. If my question can't be answered properly, tell me you can't answer it and recommend the type of lawyer who can"

    prompt = prompt_start + question + prompt_end
    
    conversation = [construct_message(inital_prompt)] if question == "" else [construct_message(prompt)]

    # while True:
    answer =  add_model_response(conversation, model_gemini_pro)
    res = {'response': answer}
    return res
        # if question.lower() == "quit":
        #     break
        # prompt = prompt_start + question + prompt_end
        # conversation.append(construct_message(prompt))


@app.route('/get-response', methods=['POST'])
def get_response_fr():
    question = request.args['text']
    print(question)
    ans =  response(question)
    return ans
@app.route('/get-response', methods=['GET'])
def get_response():
    funny = {
        "response": "I'm sorry, I didn't understand that. Can you please rephrase your question?"}
    return funny

if __name__ == "__main__":
    app.run()
            
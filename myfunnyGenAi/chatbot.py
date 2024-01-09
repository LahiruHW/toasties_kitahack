import google.generativeai as genai 


'''
Commented code, that converts an image into a blob for if you want the AI to accept multimodal input
'''
# img = Image.open('1.jpeg')
# byte_arr=  io.BytesIO()
# img.save(byte_arr, format=img.format)
# byte_arr = byte_arr.getvalue()
# encoded_image_data = base64.b64encode(byte_arr)

# image_blob = {
#     'mime_type': 'image/jpeg',
#     'data': encoded_image_data.decode('utf-8')
# }


# Configure the API key
def initialise():
    while True:
        lawyer_input = input(f"""
Choose a type of lawyer to interact with:
a. Criminal Lawyer
b. Financial Lawyer
c. Copyright Lawyer
d. Tax Lawyer
e. Employment Lawyer
""")

        match lawyer_input.lower():
            case 'a':
                lawyer_type = "criminal"
            case 'b':
                lawyer_type = "financial"
            case 'c':
                lawyer_type = "copyright"
            case 'd':
                lawyer_type = "tax"
            case 'e':
                lawyer_type = "employment"
            case _:
                print("Invalid Input")
                continue
        break



    genai.configure(api_key='AIzaSyCpVdnrotOWPjFPRXyFNMKj59E9_v8bDKw')

    # Initialize the model
    return (lawyer_type, genai.GenerativeModel('gemini-pro'))

def construct_message(message, role='user'):
    return {'role': role, 'parts': [message]}

def add_model_response(conversation, model):
    response = model.generate_content(conversation)
    response.resolve()
    conversation.append(construct_message(response.text, 'model'))
    print(conversation[-1]['parts'][0])
    print('---'*15)

if __name__ == "__main__":
    lawyer_type, model_gemini_pro = initialise()

    prompt_start = f"Answer this question as the {lawyer_type} lawyer named LAILA:\n\n"

    inital_prompt = f"Act like you are a {lawyer_type} lawyer named LAILA (Legally & Artificially Intelligent Lawyer Assistant) who is here to help me with any problems I have with {lawyer_type} law. Can you please give a short introduction of yourself to me?"

    prompt_end = f"\n\nPlease answer this question with the personality of how a good, friendly {lawyer_type} lawyer would with me ask me for more context if the question doesn't provide enough of it. If my question can't be answered properly, tell me you can't answer it and recommend the type of lawyer who can"

    conversation = [construct_message(inital_prompt)]

    while True:
        add_model_response(conversation, model_gemini_pro)
        user_input = input("Enter your next message or type 'quit' to end: ")
        print('---'*15)
        if user_input.lower() == "quit":
            break
        prompt = prompt_start + user_input + prompt_end
        conversation.append(construct_message(prompt))
import openai
import requests
import os

# Set your OpenAI API key
openai.api_key = os.getenv("OPENAI_API_KEY")

def generate_image(prompt):
    try:
        response = openai.Image.create(
            prompt=prompt,
            n=1,
            size="512x512"
        )
        image_url = response['data'][0]['url']
        return image_url
    except Exception as e:
        print(f"Error generating image: {e}")
        return None

def download_image(image_url, save_path):
    try:
        response = requests.get(image_url)
        with open(save_path, 'wb') as f:
            f.write(response.content)
        print(f"Image saved to {save_path}")
    except Exception as e:
        print(f"Error downloading image: {e}")

def main():
    prompt = input("Enter an art prompt: ")
    image_url = generate_image(prompt)
    if image_url:
        print(f"Image URL: {image_url}")
        save_option = input("Do you want to download the image? (y/n): ")
        if save_option.lower() == 'y':
            save_path = input("Enter the file path to save the image (e.g., 'art.png'): ")
            download_image(image_url, save_path)
        else:
            print("Image generation completed.")
    else:
        print("Failed to generate image.")

if __name__ == "__main__":
    main()


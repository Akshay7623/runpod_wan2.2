import json
import base64
import os

def convert_json_to_mp4(input_file='output.json'):
    # Check if the file exists in the current directory
    if not os.path.exists(input_file):
        print(f"Error: {input_file} not found in the current directory.")
        return

    try:
        # 1. Load the JSON file
        with open(input_file, 'r') as f:
            response_data = json.load(f)

        # 2. Extract media metadata and data
        # Your JSON uses the 'images' key for the video output 
        media_info = response_data["output"]["images"][0]
        base64_data = media_info["data"]
        filename = media_info["filename"]

        # 3. Decode the base64 string
        video_binary = base64.b64decode(base64_data)

        # 4. Save to an mp4 file
        with open(filename, "wb") as video_file:
            video_file.write(video_binary)

        print(f"✅ Success! Video saved as: {filename}")
        print(f"📊 Execution Stats: {response_data['executionTime'] / 1000:.2f} seconds") # 

    except KeyError:
        print("Error: The JSON structure doesn't match the expected output format.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    convert_json_to_mp4()
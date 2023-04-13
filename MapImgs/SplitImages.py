from PIL import Image
import os

def split_image(img_file, n_width, n_height):
    image = Image.open(img_file)
    width, height = image.size
    
    per_width = width / n_width
    per_height = height / n_width

    for i in range(n_width):
        for j in range(n_height):
            left = i * per_width
            top = j * per_height
            right = left + per_width
            bottom = top + per_height
            per_image = image.crop((left, top, right, bottom))
            per_image.save(f'Map_img_{i}{j}.jpg')
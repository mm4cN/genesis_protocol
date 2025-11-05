from PIL import Image
import sys

in_img = sys.argv[1]
img = Image.open(in_img)
img = img.resize((96, 96))
img.save(in_img)

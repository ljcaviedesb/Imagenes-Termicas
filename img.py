"""."""
import matplotlib.pyplot as plt
import matplotlib.colors as colors
import pandas as pd
import numpy as np
import cv2

color = cv2.imread("Fotos_color_ConFiltro/color.jpg")
infrared = cv2.imread("Fotos_color_SinFiltro/infrared.jpg")

gray_color = cv2.cvtColor(color, cv2.COLOR_BGR2GRAY)
gray_infrared = cv2.cvtColor(infrared, cv2.COLOR_BGR2GRAY)

cv2.imwrite("Fotos_gris_ConFiltro/color2gris.jpg", gray_color)
cv2.imwrite("Fotos_gris_SinFiltro/infrared2gris.jpg", gray_infrared)

result = gray_infrared ^ gray_color
result = result * 1.3715555 + 25.4
#result = (result / 5.67e-8) ** 1/4

w = result.shape[1]
h = result.shape[0]

cv2.imwrite("Resultado_resta/result.jpg", result)

image_dict = {}

for col in range(w):
    image_dict[col] = result[:, col]

image_data = pd.DataFrame(image_dict)

image_data.to_csv("Numeric_data/image_data.csv")

Z = result[int(4*h/10):int(6*h/10), int(4*w/10):int(5*w/8)]
X = range(Z.shape[1])
Y = range(Z.shape[0])


fig, ax = plt.subplots()
color_map = plt.imshow(Z)
# color_map = plt.pcolormesh(X, Y, Z)
color_map.set_cmap("hot")
fig.colorbar(color_map, ax=ax, extend="both")
plt.show()
plt.savefig("Resultado_escala/out.pdf")

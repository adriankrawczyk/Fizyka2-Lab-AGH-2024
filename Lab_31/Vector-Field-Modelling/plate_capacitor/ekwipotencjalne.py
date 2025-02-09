import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt('Book1.csv', delimiter=';')
data[data == 0] = np.nan
plt.figure(figsize=(8, 6))
levels = np.arange(np.nanmin(data), np.nanmax(data), 0.5)

rows,cols = data.shape
for x in range(rows):
  if(np.count_nonzero(np.isnan(data[x])) < 16):
    non_zero_indices = np.where(~np.isnan(data[x]))[0]
    non_zero_values = data[x][non_zero_indices]
    all_indices = np.arange(cols)
    interpolated_values = np.interp(all_indices, non_zero_indices, non_zero_values)
    np.copyto(data[x], interpolated_values)
    

plt.contour(data, levels=levels)
ax = plt.gca().invert_yaxis()

# Add labels, a colorbar, and display the plot
plt.colorbar(label="Potencjał [V]")
plt.xlabel('Numer punktu w płaszczyźnie X')
plt.ylabel('Numer punktu w płaszczyźnie Y')
plt.title('Linie ekwipotencjalne pola magnetycznego')
plt.show()
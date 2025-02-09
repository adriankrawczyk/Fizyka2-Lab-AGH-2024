import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit

# Wczytanie danych
data1 = pd.read_excel('INF3Z3ĆW134WYN.xlsx', sheet_name='AmorficzneToPandas')

# Filtrowanie tylko dodatnich wartości napięcia
data1 = data1[data1['U/n [V]'] > 0]

def exp_func(x, a, b, c):
    return a * np.exp(b * x) + c

# Dopasowanie tylko dla dodatnich wartości
popt1, _ = curve_fit(exp_func, data1['U/n [V]'], data1['j = I/S [mA/cm^2]'], 
                     p0=[0.01, 10, 0], maxfev=10000)

# Osobne zakresy dla każdego typu ogniwa
x_fit_amorf = np.linspace(0, max(data1['U/n [V]']), 1000)

plt.figure(figsize=(10, 6))
plt.plot(data1['U/n [V]'], data1['j = I/S [mA/cm^2]'], 'o', color='blue')

plt.plot(x_fit_amorf, exp_func(x_fit_amorf, *popt1), 'r-')

plt.xlabel('U/n [V]')
plt.ylabel('j = I/S [mA/(cm)^2]')
plt.title('Wykres znormalizowanej charakterystyki: I/S = f(U/n) dla ogniwa amorficznego')
plt.xlim(0.0, max((data1['U/n [V]'])))
plt.show()

# Wypisanie parametrów
print("\nParametry dopasowania (a, b, c):")
print(f"Amorficzne: {popt1}")
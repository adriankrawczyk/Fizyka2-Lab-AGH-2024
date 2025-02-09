import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit

# Wczytanie danych
data1 = pd.read_excel('INF3Z3ĆW134WYN.xlsx', sheet_name='PolikrystToPandas')
data2 = pd.read_excel('INF3Z3ĆW134WYN.xlsx', sheet_name='MonokrystToPandas')
data3 = pd.read_excel('INF3Z3ĆW134WYN.xlsx', sheet_name='AmorficzneToPandas')

# Filtrowanie tylko dodatnich wartości napięcia
data1 = data1[data1['U/n [V]'] > 0]
data2 = data2[data2['U/n [V]'] > 0]
data3 = data3[data3['U/n [V]'] > 0]

def exp_func(x, a, b, c):
    return a * np.exp(b * x) + c

# Dopasowanie tylko dla dodatnich wartości
popt1, _ = curve_fit(exp_func, data1['U/n [V]'], data1['j = I/S [mA/cm^2]'], 
                     p0=[0.1, 5, 0], maxfev=5000)
popt2, _ = curve_fit(exp_func, data2['U/n [V]'], data2['j = I/S [mA/cm^2]'], 
                     p0=[0.1, 5, 0], maxfev=5000)
# Zmienione parametry początkowe dla amorficznego
popt3, _ = curve_fit(exp_func, data3['U/n [V]'], data3['j = I/S [mA/cm^2]'], 
                     p0=[0.01, 10, 0], maxfev=10000)

# Osobne zakresy dla każdego typu ogniwa
x_fit_poli = np.linspace(0, max(data1['U/n [V]']), 1000)
x_fit_mono = np.linspace(0, max(data2['U/n [V]']), 1000)
x_fit_amorf = np.linspace(0, max(data3['U/n [V]']), 1000)

plt.figure(figsize=(10, 6))
# plt.plot(data1['U/n [V]'], data1['j = I/S [mA/cm^2]'], 'o', label='Polikrystaliczne - dane')
# plt.plot(data2['U/n [V]'], data2['j = I/S [mA/cm^2]'], 'o', label='Monokrystaliczne - dane')
# plt.plot(data3['U/n [V]'], data3['j = I/S [mA/cm^2]'], 'o', label='Amorficzne - dane')

plt.plot(x_fit_poli, exp_func(x_fit_poli, *popt1), 'r-', label='Ogniwo polikrystaliczne')
plt.plot(x_fit_mono, exp_func(x_fit_mono, *popt2), 'g-', label='Ogniwo monokrystaliczne')
plt.plot(x_fit_amorf, exp_func(x_fit_amorf, *popt3), 'b-', label='Ogniwo amorficzne')

plt.xlabel('U/n [V]')
plt.ylabel('j = I/S [mA/(cm)^2]')
plt.title('Wykres znormalizowanych charakterystyk: I/S = f(U/n) dla 3 fotoogniw')
plt.legend()
plt.xlim(0.0, max(max(data1['U/n [V]']), max(data2['U/n [V]']), max(data3['U/n [V]'])))
plt.show()

# Wypisanie parametrów
print("\nParametry dopasowania (a, b, c):")
print(f"Polikrystaliczne: {popt1}")
print(f"Monokrystaliczne: {popt2}")
print(f"Amorficzne: {popt3}")
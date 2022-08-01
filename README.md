# ECG Spectral Analysis
Electrocardiographic signal of a healthy human resembles periodic signal consisting of typical wavelets (P,Q,R,S,T,U waves).
Each beat in the ECG comprises a P-QRS-T complex. Although the waveform is periodic, yet the cardiac period of human heart is not constant. It exhibits fluctuations depending upon the frequency of each P, QRS and T peaks.

### Spectral Analysis
Spectral analysis could be performed using various schemes, each having its own consideration factors. In order to interpret the spectrum correctly, some prior knowledge about spectral properties of medical signals is required. Spectrum of ECG signal is affected by wavelet shapes, their positions within cardiac cycle as well as by the regularity of heartbeats.

The repository analyzes the spectrum of ECG samples acquired from <a href="https://archive.physionet.org/cgi-bin/atm/ATM?database=nsrdb&tool=plot_waveforms" target="blank_">PhysioBank</a> data archive. The analysis is built upon Fast Fourier Transform which requires that the signal to be analyzed should be 3-5 minutes long. Before applying <i>fft( )</i>, as a part of preprocessing, the signal is detrended which removes the linear trends. This allows calculating the heartrate by determining the R-peaks’ locations. Following results have been obtained.
<p align="center">
  <img src="https://github.com/rimshasaeed/ecg-spectral-analysis/blob/main/results/figure1.jpg", alt="ecg signal" width="50%">
  <br>
  <i>ECG signal</i>
</p>
<p align="center">
  <img src="https://github.com/rimshasaeed/ecg-spectral-analysis/blob/main/results/figure2.jpg", alt="psd" width="50%">
  <br>
  <i>Spectral information</i>
</p>

Following inferences could be drawn.
1. ECG signal comprises of three frequency components, namely:
   - Very low frequency band: 0.003 - 0.04 samples/cycle
   - Low frequency band: 0.040 - 0.15 samples/cycle 
   - High frequency band: 0.150 - 0.40 samples/cycle
2. Fundamental frequency exists in the range of 0.003 - 0.04 samples/cycle i.e., in the range of very low frequency components.
3. Low frequency band exhibit maximum signal power: hence, the most dominant one.

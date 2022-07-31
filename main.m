clc, clearvars, close all

load('data/ecg_sample1.mat')
ecg_analysis(ecg, fs, gain, 2);

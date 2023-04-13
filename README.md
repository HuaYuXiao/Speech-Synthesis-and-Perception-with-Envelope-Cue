# Speech-synthesis-and-perception-with-envelope-cue
SUSTech EE205 Signal and System

## Overview
In this tutorial, you will learn to synthesize a speech signal based on multi-band envelope cues.

## Acoustic cues of speech signal

![README_page-0003](https://user-images.githubusercontent.com/117464811/231826530-db549a2a-f7f8-45f0-8e5b-906acc301ff0.jpg)

![README_page-0004](https://user-images.githubusercontent.com/117464811/231826561-4c429d29-87dc-42ac-b2c6-2f06423ab9df.jpg)

## Speech synthesis with envelope cue

### Tone vocoder

![README_page-0005](https://user-images.githubusercontent.com/117464811/231826807-8b244361-2fe0-4fba-b81b-e7b5f5bc4124.jpg)

### Band pass filter

![README_page-0006](https://user-images.githubusercontent.com/117464811/231826931-08552b5c-8ae5-483e-949e-a1d96a0aefd2.jpg)

## Example

![README_page-0008](https://user-images.githubusercontent.com/117464811/231827064-4dd9eb2a-2f43-4746-9380-bf51e6317db4.jpg)

## Project tasks

Sentences for pro 1:‘C_01_01.wav’ & ‘C_01_02.wav’

### Task 1
1. Set LPF cut off frequency to 50 Hz.
2. Implement tone vocoder by changing the number of bands to N=1, N=2, N=4, N=6, and N=8.
3. Save the wave files for these conditions, and describe how the number of bands affects the intelligibility (i.e., how many words can be understood) of synthesized sentence.

### Task 2
1. Set the number of bands N=4.
2. Implement tone vocoder by changing the LPF cut off frequency to 20 Hz, 50 Hz, 100 Hz, and 400 Hz.
3. Describe how the LPF cut off frequency affects the intelligibility of synthesized sentence.

### Task 3
1. Generate a noisy signal (summing clean sentence and SSN) at SNR 5 dB.
2. Set LPF cut off frequency to 50 Hz.
3. Implement tone vocoder by changing the number of bands to N=2, N=4, N=6, N=8, and N=16.
4. Describe how the number of bands affects the intelligibility of synthesized sentence, and compare findings with those obtained in task 1.

### Task 4
1. Generate a noisy signal (summing clean sentence and SSN) at SNR 5 dB.
2. Set the number of bands to N=6.
3. Implement tone vocoder by changing the LPF cut off frequency to 20 Hz, 50 Hz, 100 Hz, and 400 Hz.
4. Describe how the LPF cut off frequency affects the intelligibility of synthesized sentence.

## Results

![image](https://user-images.githubusercontent.com/117464811/231827885-bad0004c-af1e-45c2-b165-9233d83efb32.png)

## Application: Cochlear Implants

![image](https://user-images.githubusercontent.com/117464811/231827981-0bde1939-2883-4357-8fbb-2df1330abfe4.png)

## Speech processing in cochlear implants

![README_page-0015](https://user-images.githubusercontent.com/117464811/231828408-a499559b-86a1-47b2-8bc2-da258839df30.jpg)

![image](https://user-images.githubusercontent.com/117464811/231828072-874eb492-ba23-49df-b90b-fd4f20b4487f.png)

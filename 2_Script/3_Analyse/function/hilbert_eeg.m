function eegFFT = hilbert_eeg(eegData, freqRange, srate)

% bandpass filter with a frequency range 
% eegData = EEG.data; channel * time * trials. 
% freqRange = [lowerFreq, higherFreq];
% eegFFT: output power of the input frequency range.

eegFFT = nan(size(eegData));
for c = 1:size(eegData,1)

    tmp = squeeze(eegData(c,:,:));
    [row,col] = size(tmp);       
    tmp = tmp(:)';
    tmp = abs(hilbert(eegfilt(tmp,srate,freqRange(1),freqRange(2)))).^2;

    eegFFT(c,:,:) = reshape(tmp,[row,col]);

end


end
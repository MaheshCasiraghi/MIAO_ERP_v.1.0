function [Variances] = M013_ICA_GetCompVariances(EEG)
%[Variances] = M013_ICA_GetCompVariances(EEG)
            Activations = eeg_getica(EEG);
            Variances = var(Activations(:,:),[],2);
            Variances = 100*Variances./sum(Variances);
%   Detailed explanation goes here


end


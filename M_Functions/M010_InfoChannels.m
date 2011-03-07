%[chanmat] = M010_InfoChannels(EEG). An object chanmat is saved an displayed, containing all the channel information of the dataset.
function [chanmat] = M010_InfoChannels(EEG)
%[chanmat] = M010_InfoChannels(EEG). An object chanmat is saved an displayed, containing all the channel information of the dataset.
%   Detailed explanation goes here
chanstring={EEG.chanlocs.labels};
chanordinal={EEG.chanlocs.urchan};
theta={EEG.chanlocs.theta};
radius={EEG.chanlocs.radius};
X={EEG.chanlocs.X};
Y={EEG.chanlocs.Y};
Z={EEG.chanlocs.Z};
sph_theta={EEG.chanlocs.sph_theta};
sph_phi={EEG.chanlocs.sph_phi};
sph_radius={EEG.chanlocs.sph_radius};
type={EEG.chanlocs.type};
ref={EEG.chanlocs.ref};
dati=[chanordinal;chanstring;theta;radius;X;Y;Z;sph_theta;sph_phi;sph_radius;type;ref];
chanmatgir=dati';
intestazione={'ID' 'Channel_Name' 'Theta' 'Radius' 'X' 'Y' 'Z' 'Sph_Theta' 'Sph_Phi' 'Sph_Radius' 'Type' 'Reference'}
chanmat=[intestazione;chanmatgir]
end


%[TODOLIST] = M017_CREATE_TODOLIST(number of subjects)
function [TODOLIST] = M017_CREATE_TODOLIST(number)
%[TODOLIST] = M017_CREATE_TODOLIST(12) : Creates the TODOLIST to RULE THE
%PREPROCESSING ROUTINE.
%   Detailed explanation goes here
for i=1:number
TODOLIST(i).filename = ['sj0' num2str(i)];
TODOLIST(i).IN_directory = 'C:\BDFs\';
TODOLIST(i).OUT_directory = 'C:\SETs\';
TODOLIST(i).IN_filename = [TODOLIST(i).filename '.bdf'];
TODOLIST(i).OUT_filename = [TODOLIST(i).filename '.set'];
TODOLIST(i).List_Channels_Sources = {};
TODOLIST(i).List_Channels_Destinations = {};
TODOLIST(i).Reference_Channels_Indices = [65 66];
TODOLIST(i).Operation_ChangeMarkers = '-65280';
TODOLIST(i).Channels_2_Delete = {'EXG6' 'EXG7' 'EXG8'};
TODOLIST(i).Epoch_TimeEdges = [-3000.0 1400.0];
%Note that baseline's edges should be 5ms from epoch edges to avoid the risk of errors.
TODOLIST(i).Baseline_TimeEdges = [-2995.0 -2795.0];
%The same applies to Artifact Rejection Edges.
TODOLIST(i).AR_TimeEdges = [-2995.0 1395.0];
TODOLIST(i).Electrode_Location_File = 'C:\\Program Files\\MATLAB\\R2010b\\toolbox\\eeglab9_0_0_2b\\plugins\\dipfit2.2\\standard_BESA\\standard-10-5-cap385.elp';
TODOLIST(i).Event_Parameters_File = 'C:\BDFs\Event_Parameters_File.txt';
TODOLIST(i).Bin_Descriptor_File = 'C:\BDFs\Bin_Descriptor_File.txt';
TODOLIST(i).Eventlist_File_Mrk = ['C:\SETs\' TODOLIST(i).OUT_filename '_EVENTLIST_MRK.txt'];
TODOLIST(i).EventList_File_Bin = ['C:\SETs\' TODOLIST(i).OUT_filename '_EVENTLIST_BIN.txt'];
TODOLIST(i).AR_Report_File = ['C:\SETs\' TODOLIST(i).OUT_filename '_AR_Summary.txt'];
end
end


%[ERP] = M032_EMPTY_ERP(ERP);
function [ERP] = M032_EMPTY_ERP(ERP)
%Creates an empty ERP structures with all the fields ready to be filled
 ERP = [];
        ERP.filename   = [];
        ERP.filepath   = [];
        ERP.workfiles  = [];
        ERP.subject    = [];
        ERP.nchan      = [];
        ERP.nbin       = 0;
        ERP.pnts       = 0;
        ERP.srate      = [];
        ERP.xmin       = [];
        ERP.xmax       = [];
        ERP.times      = [];
        ERP.bindata    = [];
        ERP.binerror   = []; 
        ERP.chanlocs   = [];
        ERP.ref        = [];
        ERP.bindescr   = [];
        ERP.ntrials.accepted  = [];
        ERP.ntrials.rejected  = [];
        ERP.ntrials.invalid   = [];
        ERP.history    = [];
        ERP.saved      = 'no';
        ERP.isfilt     = [];
        ERP.EVENTLIST  = [];
        ERP.version    = geterplabversion;
        [ERP serror]   = sorterpstruct(ERP);
end


function eegProcessNames = LoadGeneralProcessInfos()
    eegProcessNames = {...        
        'create_subject', @CreateSubjectDetails, @CreateSubjectParameter; ...
        'import_anatomy', @ImportAnatomyDetails, @ImportAnatomyParameter; ...
        'review_raw_files', @ReviewRawFilesDetails, @ReviewRawFilesParameter; ...
        'split_raw_files', @SplitRawFilesDetails, @SplitRawFilesParameter; ...
        'export_to_bids', @ExportToBidsDetails, @ExportToBidsParameter;... ...
        'reject_bad_trials', @RejectBadTrialsDetails, @RejectBadTrialsParameter;...
        'import_events', @ImportEventsDetails, @ImportEventsParameter; ...
        'import_time_between_event', @ImportTimeBetweenEventDetails, @ImportTimeBetweenEventParameter; ...
        'import_time', @ImportTimeDetails, @ImportTimeParameter; ...
        'average', @AverageDetails, @AverageParameter; ...
        'compute_sources', @ComputeSourcesDetails, @ComputeSourcesParameter;... ...
        'detect_cardiac_artifact', @DetectCardiacArtifactDetails, @DetectCardiacArtifactParameter; ...
        'detect_blink_artifact', @DetectBlinkArtifactDetails, @DetectBlinkArtifactParameter; ...
        'export_data', @ExportDataDetails, @ExportDataParameter; ...
        };
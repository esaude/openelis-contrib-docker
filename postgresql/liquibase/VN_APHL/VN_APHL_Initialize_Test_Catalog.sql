/* Remove existing units */
TRUNCATE TABLE clinlims.unit_of_measure CASCADE;
ALTER SEQUENCE clinlims.unit_of_measure_seq restart 1;
ALTER SEQUENCE clinlims.inventory_item_seq restart 1;
ALTER SEQUENCE clinlims.inventory_location_seq restart 1;
/* Remove existing select list values */
DELETE FROM clinlims.dictionary where dictionary_category_id in ( select id from clinlims.dictionary_category where description = 'Haiti Lab' );
/* Remove existing sample types */
TRUNCATE TABLE clinlims.type_of_sample CASCADE;
ALTER SEQUENCE clinlims.type_of_sample_seq restart 1;
ALTER SEQUENCE clinlims.sample_type_panel_seq restart 1;
/* Remove existing panels */
TRUNCATE TABLE clinlims.panel CASCADE;
ALTER SEQUENCE clinlims.panel_seq restart 1;
ALTER SEQUENCE clinlims.panel_item_seq restart 1;
/* Remove existing localization data */
TRUNCATE TABLE clinlims.localization CASCADE;
ALTER TABLE clinlims.localization ADD COLUMN vietnamese text NOT NULL;
ALTER SEQUENCE clinlims.localization_seq restart 1;
/* Insert required values */
INSERT INTO clinlims.test_section ( id, name, description, is_external, lastupdated, display_key, sort_order, is_active ) VALUES
	( nextval( 'test_section_seq' ), 'user', 'Indicates user will chose test section', 'N', now(), NULL, 0, 'N');
INSERT INTO clinlims.type_of_sample ( id, description, domain, lastupdated, local_abbrev, display_key, sort_order, is_active ) VALUES
	( nextval( 'type_of_sample_seq' ), 'Actual type will be selected by user', 'H', now(), 'Variable', 'sample.type.variable', 0, 'N');
/* Insert VN QA Events */
INSERT INTO clinlims.qa_event ( id, name, description, is_holdable, lastupdated, category, type, display_key ) VALUES
	( nextval( 'qa_event_seq' ) , 'Incomplete form', 'Inappropriate or incomplete request form', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Request Form Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.form.incomplete'),
	( nextval( 'qa_event_seq' ) , 'No test request form', 'No test request form', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Request Form Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.form.no.form'),
	( nextval( 'qa_event_seq' ) , 'No test requested', 'No test requested', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Request Form Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.form.no.tests'),
	( nextval( 'qa_event_seq' ) , 'Test not available', 'Test not available', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Request Form Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.form.test.na'),
	( nextval( 'qa_event_seq' ) , 'No collection date', 'No collection date on form', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Request Form Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.form.no.date'),
	( nextval( 'qa_event_seq' ) , 'Improperly labeled', 'Improperly labeled or unlabeled', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Labeling Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.label.unlabeled'),
	( nextval( 'qa_event_seq' ) , 'No patient info', 'Lacks patient information (name, patient ID)', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Labeling Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.label.no.patient'),
	( nextval( 'qa_event_seq' ) , 'No collection date', 'Lacks collection date and time', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Labeling Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.label.no.date'),
	( nextval( 'qa_event_seq' ) , 'No specimen origin', 'Lacks specimen origin', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Labeling Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.label.no.origin'),
	( nextval( 'qa_event_seq' ) , 'Can''t find sample ID', 'Sample ID can not be established', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Labeling Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.label.bad.sampleID'),
	( nextval( 'qa_event_seq' ) , 'Can''t read sample ID', 'Sample ID not legible', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Labeling Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.label.illegible.sampleID'),
	( nextval( 'qa_event_seq' ) , 'No sample ID', 'No sample ID', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Labeling Errors' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.label.no.sampleID'),
	( nextval( 'qa_event_seq' ) , 'No sample received', 'No sample received', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.no.sample'),
	( nextval( 'qa_event_seq' ) , 'Mixed up specimens', 'Disorderly mixed up specimens', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.mixedup'),
	( nextval( 'qa_event_seq' ) , 'Patient not prepared', 'Patient not properly prepared for test', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.patient.not.ready'),
	( nextval( 'qa_event_seq' ) , 'Improperly collected', 'Improperly collected', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.improperly.collected'),
	( nextval( 'qa_event_seq' ) , 'Improperly preserved', 'Improperly preserved', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.improperly.preserved'),
	( nextval( 'qa_event_seq' ) , 'Clotted', 'Clotted', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.clotted'),
	( nextval( 'qa_event_seq' ) , 'Hemolytic', 'Hemolytic', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.hemolytic'),
	( nextval( 'qa_event_seq' ) , 'Lipemic', 'Lipemic', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.lipemic'),
	( nextval( 'qa_event_seq' ) , 'Not enough quantity', 'Quantity insufficient', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.no.quantity'),
	( nextval( 'qa_event_seq' ) , 'Improper container', 'Improper container or blood tube (e.g. non-EDTA for CD4 specimens)', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.bad.container'),
	( nextval( 'qa_event_seq' ) , 'Bad sample type', 'Sample type unacceptable for test', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.bad.sample.type'),
	( nextval( 'qa_event_seq' ) , 'Expired media', 'Expired transport media', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.expired.transport'),
	( nextval( 'qa_event_seq' ) , 'Improper media', 'Improper transport media', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.bad.transport'),
	( nextval( 'qa_event_seq' ) , 'Expired timeframe', 'Not received or tested in proper timeframe', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.expired.time'),
	( nextval( 'qa_event_seq' ) , 'Bad receipt temp.', 'Received or transported at improper temperature', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.bad.receipt.temp'),
	( nextval( 'qa_event_seq' ) , 'Bad storage temp.', 'Stored at improper temperature', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.bad.storage.temp'),
	( nextval( 'qa_event_seq' ) , 'Damaged', 'Damaged, leaking or contaminated', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Miscellaneous' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.misc.damaged'),
	( nextval( 'qa_event_seq' ) , 'Other', 'Other', 'Y' , now(),  ( select id from clinlims.dictionary where dict_entry = 'Other' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Category' ) ), ( select id from clinlims.dictionary where dict_entry = 'Rejection Reason(s)' and dictionary_category_id = ( select id from clinlims.dictionary_category where description = 'QA Event Type' ) ), 'qa.event.rejection.reason.other');
/* Below generated from test catalog */
INSERT INTO clinlims.test_section ( id, name, description, is_external, lastupdated, display_key, sort_order, is_active ) VALUES
	( nextval( 'test_section_seq' ), 'Biochemistry', 'Biochemistry', 'N', now(), 'test.section.biochemistry', 10, 'Y');
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'g/l', 'g/l', now());
INSERT INTO clinlims.type_of_sample ( id, description, domain, lastupdated, local_abbrev, display_key, sort_order, is_active ) VALUES
	( nextval( 'type_of_sample_seq' ), 'CSF', 'H', now(), 'CSF', 'sample.type.csf', 10, 'Y');
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Protein, CSF', '', 'Protein LCR', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Protein, CSF', '', 'Protein LCR', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Protein LCR(CSF)', 'Protein LCR', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1001', 10, 'Protein LCR', '2880-3', 'ovn-1001', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Protein LCR' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Protein LCR' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'CSF' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein LCR(CSF)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein LCR(CSF)' ), 'N', NULL, now(), 10, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein LCR(CSF)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 0.45);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Glucose, CSF', '', 'Sucre LCR', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Glucose, CSF', '', 'Sucre LCR', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Sucre LCR(CSF)', 'Sucre LCR', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1002', 20, 'Sucre LCR', '2342-4', 'ovn-1002', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Sucre LCR' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Sucre LCR' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'CSF' ), ( SELECT id FROM clinlims.test WHERE description = 'Sucre LCR(CSF)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sucre LCR(CSF)' ), 'N', NULL, now(), 20, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sucre LCR(CSF)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.40, 0.60);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mmol/l', 'mmol/l', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Chloride, CSF', '', 'Chlor LCR', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Chloride, CSF', '', 'Chlor LCR', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmol/l' ), 'Chlor LCR(CSF)', 'Chlor LCR', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1003', 30, 'Chlor LCR', '2070-1', 'ovn-1003', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Chlor LCR' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Chlor LCR' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'CSF' ), ( SELECT id FROM clinlims.test WHERE description = 'Chlor LCR(CSF)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Chlor LCR(CSF)' ), 'N', NULL, now(), 30, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Chlor LCR(CSF)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 120.00, 130.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lactate, CSF', '', 'Lactac LCR', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lactate, CSF', '', 'Lactac LCR', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmol/l' ), 'Lactac LCR(CSF)', 'Lactac LCR', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1004', 40, 'Lactac LCR', '2520-5', 'ovn-1004', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Lactac LCR' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Lactac LCR' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'CSF' ), ( SELECT id FROM clinlims.test WHERE description = 'Lactac LCR(CSF)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lactac LCR(CSF)' ), 'N', NULL, now(), 40, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lactac LCR(CSF)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 1.20, 2.10);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'UL', 'UL', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'LDH, CSF', '', 'LDH LCR', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'LDH, CSF', '', 'LDH LCR', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'LDH LCR(CSF)', 'LDH LCR', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1005', 50, 'LDH LCR', '60024-7', 'ovn-1005', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'LDH LCR' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'LDH LCR' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'CSF' ), ( SELECT id FROM clinlims.test WHERE description = 'LDH LCR(CSF)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LDH LCR(CSF)' ), 'N', NULL, now(), 50, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LDH LCR(CSF)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.type_of_sample ( id, description, domain, lastupdated, local_abbrev, display_key, sort_order, is_active ) VALUES
	( nextval( 'type_of_sample_seq' ), 'Dịch', 'H', now(), 'Dịch', 'sample.type.body.fluid', 20, 'Y');
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Protein, body fluid', '', 'Protein - Liquid', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Protein, body fluid', '', 'Protein - Liquid', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Protein - Liquid(Dịch)', 'Protein - Liquid', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1006', 60, 'Protein - Liquid', '2881-1', 'ovn-1006', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Protein - Liquid' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Protein - Liquid' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Dịch' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein - Liquid(Dịch)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein - Liquid(Dịch)' ), 'N', NULL, now(), 60, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein - Liquid(Dịch)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'LDH, body fluid', '', 'LDH - Liquid', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'LDH, body fluid', '', 'LDH - Liquid', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'LDH - Liquid(Dịch)', 'LDH - Liquid', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1007', 70, 'LDH - Liquid', '14803-1', 'ovn-1007', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'LDH - Liquid' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'LDH - Liquid' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Dịch' ), ( SELECT id FROM clinlims.test WHERE description = 'LDH - Liquid(Dịch)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LDH - Liquid(Dịch)' ), 'N', NULL, now(), 70, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LDH - Liquid(Dịch)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lactate, body fluid', '', 'Lactac - Liquid', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lactate, body fluid', '', 'Lactac - Liquid', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmol/l' ), 'Lactac - Liquid(Dịch)', 'Lactac - Liquid', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1008', 80, 'Lactac - Liquid', '14165-5', 'ovn-1008', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Lactac - Liquid' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Lactac - Liquid' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Dịch' ), ( SELECT id FROM clinlims.test WHERE description = 'Lactac - Liquid(Dịch)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lactac - Liquid(Dịch)' ), 'N', NULL, now(), 80, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lactac - Liquid(Dịch)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mg/l', 'mg/l', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bilirubin, body fluid', '', 'Bilirubin - Liquid', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bilirubin, body fluid', '', 'Bilirubin - Liquid', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/l' ), 'Bilirubin - Liquid(Dịch)', 'Bilirubin - Liquid', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1009', 90, 'Bilirubin - Liquid', '1974-5', 'ovn-1009', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Bilirubin - Liquid' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Bilirubin - Liquid' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Dịch' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin - Liquid(Dịch)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin - Liquid(Dịch)' ), 'N', NULL, now(), 90, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin - Liquid(Dịch)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Glucose, body fluid', '', 'Glucose - Liquid', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Glucose, body fluid', '', 'Glucose - Liquid', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Glucose - Liquid(Dịch)', 'Glucose - Liquid', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1010', 100, 'Glucose - Liquid', '2344-0', 'ovn-1010', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Glucose - Liquid' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Glucose - Liquid' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Dịch' ), ( SELECT id FROM clinlims.test WHERE description = 'Glucose - Liquid(Dịch)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Glucose - Liquid(Dịch)' ), 'N', NULL, now(), 100, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Glucose - Liquid(Dịch)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Amylase, body fluid', '', 'Amylase - Liquid', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Amylase, body fluid', '', 'Amylase - Liquid', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'Amylase - Liquid(Dịch)', 'Amylase - Liquid', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1011', 110, 'Amylase - Liquid', '1795-4', 'ovn-1011', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Amylase - Liquid' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Amylase - Liquid' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Dịch' ), ( SELECT id FROM clinlims.test WHERE description = 'Amylase - Liquid(Dịch)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amylase - Liquid(Dịch)' ), 'N', NULL, now(), 110, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amylase - Liquid(Dịch)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lipase, body fluid', '', 'Lipase - Liquid', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lipase, body fluid', '', 'Lipase - Liquid', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'Lipase - Liquid(Dịch)', 'Lipase - Liquid', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1012', 120, 'Lipase - Liquid', '15212-4', 'ovn-1012', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Lipase - Liquid' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Lipase - Liquid' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Dịch' ), ( SELECT id FROM clinlims.test WHERE description = 'Lipase - Liquid(Dịch)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lipase - Liquid(Dịch)' ), 'N', NULL, now(), 120, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lipase - Liquid(Dịch)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Urea, body fluid', '', 'Uree dịch', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Urea, body fluid', '', 'Uree dịch', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Uree dịch(Dịch)', 'Uree dịch', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1013', 130, 'Uree dịch', '57392-3', 'ovn-1013', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Uree dịch' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Uree dịch' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Dịch' ), ( SELECT id FROM clinlims.test WHERE description = 'Uree dịch(Dịch)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Uree dịch(Dịch)' ), 'N', NULL, now(), 130, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Uree dịch(Dịch)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Creatinine, body fluid', '', 'Crea dịch', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Creatinine, body fluid', '', 'Crea dịch', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/l' ), 'Crea dịch(Dịch)', 'Crea dịch', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1014', 140, 'Crea dịch', '12190-5', 'ovn-1014', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Crea dịch' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Crea dịch' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Dịch' ), ( SELECT id FROM clinlims.test WHERE description = 'Crea dịch(Dịch)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Crea dịch(Dịch)' ), 'N', NULL, now(), 140, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Crea dịch(Dịch)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'n/a', 'n/a', now());
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Âm tính', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Dương tính', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.type_of_sample ( id, description, domain, lastupdated, local_abbrev, display_key, sort_order, is_active ) VALUES
	( nextval( 'type_of_sample_seq' ), 'Phân', 'H', now(), 'Phân', 'sample.type.stool', 30, 'Y');
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Urobilinogen, stool', '', 'Stercobilinogene', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Urobilinogen, stool', '', 'Stercobilinogene', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'n/a' ), 'Stercobilinogene(Phân)', 'Stercobilinogene', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1015', 150, 'Stercobilinogene', '3105-4', 'ovn-1015', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Stercobilinogene' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Stercobilinogene' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Phân' ), ( SELECT id FROM clinlims.test WHERE description = 'Stercobilinogene(Phân)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Stercobilinogene(Phân)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 150, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Stercobilinogene(Phân)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 160, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Blood', '', 'Blood', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Blood', '', 'Blood', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'n/a' ), 'Blood(Phân)', 'Blood', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1016', 160, 'Blood', '2335-8', 'ovn-1016', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Blood' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Blood' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Phân' ), ( SELECT id FROM clinlims.test WHERE description = 'Blood(Phân)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Blood(Phân)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 180, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Blood(Phân)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 190, NULL, false);
INSERT INTO clinlims.type_of_sample ( id, description, domain, lastupdated, local_abbrev, display_key, sort_order, is_active ) VALUES
	( nextval( 'type_of_sample_seq' ), 'Huyết thanh', 'H', now(), 'Huyết than', 'sample.type.serum', 40, 'Y');
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'C-reactive protein', '', 'CRP', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'C-reactive protein', '', 'CRP', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/l' ), 'CRP(Huyết thanh)', 'CRP', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1017', 170, 'CRP', '1988-5', 'ovn-1017', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CRP' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CRP' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'CRP(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CRP(Huyết thanh)' ), 'N', NULL, now(), 210, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CRP(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 5.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bilirubin.total', '', 'Bilirubin Total', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bilirubin.total', '', 'Bilirubin Total', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/l' ), 'Bilirubin Total(Huyết thanh)', 'Bilirubin Total', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1018', 180, 'Bilirubin Total', '1975-2', 'ovn-1018', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Bilirubin Total' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Bilirubin Total' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin Total(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin Total(Huyết thanh)' ), 'N', NULL, now(), 220, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin Total(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 14.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bilirubin.direct', '', 'Bilirubin Direct', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bilirubin.direct', '', 'Bilirubin Direct', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/l' ), 'Bilirubin Direct(Huyết thanh)', 'Bilirubin Direct', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1019', 190, 'Bilirubin Direct', '1968-7', 'ovn-1019', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Bilirubin Direct' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Bilirubin Direct' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin Direct(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin Direct(Huyết thanh)' ), 'N', NULL, now(), 230, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin Direct(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 3.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bilirubin.indirect', '', 'Bilirubin Indirect', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bilirubin.indirect', '', 'Bilirubin Indirect', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'n/a' ), 'Bilirubin Indirect(Huyết thanh)', 'Bilirubin Indirect', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1020', 200, 'Bilirubin Indirect', '1971-1', 'ovn-1020', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Bilirubin Indirect' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Bilirubin Indirect' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin Indirect(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin Indirect(Huyết thanh)' ), 'N', NULL, now(), 240, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bilirubin Indirect(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Aspartate aminotransferase', '', 'SGOT/ ASAT', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Aspartate aminotransferase', '', 'SGOT/ ASAT', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'SGOT/ ASAT(Huyết thanh)', 'SGOT/ ASAT', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1021', 210, 'SGOT/ ASAT', '1920-8', 'ovn-1021', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'SGOT/ ASAT' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'SGOT/ ASAT' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'SGOT/ ASAT(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'SGOT/ ASAT(Huyết thanh)' ), 'N', NULL, now(), 250, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'SGOT/ ASAT(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 40.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Alanine aminotransferase', '', 'SGPT/ ALAT', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Alanine aminotransferase', '', 'SGPT/ ALAT', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'SGPT/ ALAT(Huyết thanh)', 'SGPT/ ALAT', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1022', 220, 'SGPT/ ALAT', '1742-6', 'ovn-1022', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'SGPT/ ALAT' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'SGPT/ ALAT' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'SGPT/ ALAT(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'SGPT/ ALAT(Huyết thanh)' ), 'N', NULL, now(), 260, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'SGPT/ ALAT(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 45.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Alkaline phosphatase', '', 'Phosphatase Alkalin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Alkaline phosphatase', '', 'Phosphatase Alkalin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'Phosphatase Alkalin(Huyết thanh)', 'Phosphatase Alkalin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1023', 230, 'Phosphatase Alkalin', '6768-6', 'ovn-1023', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Phosphatase Alkalin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Phosphatase Alkalin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Phosphatase Alkalin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Phosphatase Alkalin(Huyết thanh)' ), 'N', NULL, now(), 270, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Phosphatase Alkalin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 300.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Gamma-glutamyl transpeptidase', '', 'Gamma GT', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Gamma-glutamyl transpeptidase', '', 'Gamma GT', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'Gamma GT(Huyết thanh)', 'Gamma GT', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1024', 240, 'Gamma GT', '2324-2', 'ovn-1024', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Gamma GT' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Gamma GT' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Gamma GT(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gamma GT(Huyết thanh)' ), 'N', NULL, now(), 280, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gamma GT(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 7.00, 45.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Urea nitrogen', '', 'Urê', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Urea nitrogen', '', 'Urê', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Urê(Huyết thanh)', 'Urê', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1025', 250, 'Urê', '3094-0', 'ovn-1025', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Urê' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Urê' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Urê(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Urê(Huyết thanh)' ), 'N', NULL, now(), 290, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Urê(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.10, 0.45);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Creatinine', '', 'Creatinin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Creatinine', '', 'Creatinin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/l' ), 'Creatinin(Huyết thanh)', 'Creatinin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1026', 260, 'Creatinin', '2160-0', 'ovn-1026', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Creatinin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Creatinin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Creatinin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Creatinin(Huyết thanh)' ), 'N', NULL, now(), 300, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Creatinin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 2.30, 10.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Protein.total', '', 'Protein total', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Protein.total', '', 'Protein total', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Protein total(Huyết thanh)', 'Protein total', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1027', 270, 'Protein total', '2885-2', 'ovn-1027', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Protein total' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Protein total' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein total(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein total(Huyết thanh)' ), 'N', NULL, now(), 310, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein total(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 60.00, 80.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Albumin', '', 'Albumin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Albumin', '', 'Albumin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Albumin(Huyết thanh)', 'Albumin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1028', 280, 'Albumin', '1751-7', 'ovn-1028', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Albumin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Albumin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Albumin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Albumin(Huyết thanh)' ), 'N', NULL, now(), 320, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Albumin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 38.00, 55.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cholesterol', '', 'Cholesterol', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cholesterol', '', 'Cholesterol', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Cholesterol(Huyết thanh)', 'Cholesterol', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1029', 290, 'Cholesterol', '2093-3', 'ovn-1029', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cholesterol' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cholesterol' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Cholesterol(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cholesterol(Huyết thanh)' ), 'N', NULL, now(), 330, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cholesterol(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 2.20);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Triglyceride', '', 'Triglycerid', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Triglyceride', '', 'Triglycerid', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Triglycerid(Huyết thanh)', 'Triglycerid', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1030', 300, 'Triglycerid', '2571-8', 'ovn-1030', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Triglycerid' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Triglycerid' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Triglycerid(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Triglycerid(Huyết thanh)' ), 'N', NULL, now(), 340, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Triglycerid(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 1.50);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cholesterol.HDL', '', 'HDL-cho', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cholesterol.HDL', '', 'HDL-cho', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'HDL-cho(Huyết thanh)', 'HDL-cho', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1031', 310, 'HDL-cho', '2085-9', 'ovn-1031', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HDL-cho' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HDL-cho' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'HDL-cho(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HDL-cho(Huyết thanh)' ), 'N', NULL, now(), 350, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HDL-cho(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.35);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cholesterol.LDL', '', 'LDL-cho', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cholesterol.LDL', '', 'LDL-cho', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'LDL-cho(Huyết thanh)', 'LDL-cho', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1032', 320, 'LDL-cho', '2089-1', 'ovn-1032', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'LDL-cho' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'LDL-cho' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'LDL-cho(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LDL-cho(Huyết thanh)' ), 'N', NULL, now(), 360, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LDL-cho(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 1.50);
INSERT INTO clinlims.panel ( id, name, description, lastupdated, display_key, sort_order ) VALUES
	( nextval( 'panel_seq' ), 'Electrolytes', 'Electrolytes', now(), 'panel.name.electrolytes', 10);
INSERT INTO clinlims.sampletype_panel ( id, sample_type_id, panel_id ) VALUES
	( nextval( 'sample_type_panel_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.panel WHERE name = 'Electrolytes' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mEq/l', 'mEq/l', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Potassium', '', 'K+', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Potassium', '', 'K+', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mEq/l' ), 'K+(Huyết thanh)', 'K+', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1034', 330, 'K+', '2823-3', 'ovn-1034', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'K+' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'K+' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'K+(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'K+(Huyết thanh)' ), 'N', NULL, now(), 370, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'K+(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 3.50, 5.10);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Electrolytes' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'K+(Huyết thanh)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Sodium', '', 'Na+', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Sodium', '', 'Na+', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mEq/l' ), 'Na+(Huyết thanh)', 'Na+', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1035', 340, 'Na+', '2951-2', 'ovn-1035', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Na+' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Na+' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Na+(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Na+(Huyết thanh)' ), 'N', NULL, now(), 380, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Na+(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 135.00, 145.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Electrolytes' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Na+(Huyết thanh)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Calcium++', '', 'Ca++', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Calcium++', '', 'Ca++', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mEq/l' ), 'Ca++(Huyết thanh)', 'Ca++', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1036', 350, 'Ca++', '1995-0', 'ovn-1036', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ca++' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ca++' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca++(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca++(Huyết thanh)' ), 'N', NULL, now(), 390, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca++(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 2.20, 2.90);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Electrolytes' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ca++(Huyết thanh)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Chloride', '', 'Cl-', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Chloride', '', 'Cl-', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mEq/l' ), 'Cl-(Huyết thanh)', 'Cl-', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1037', 360, 'Cl-', '2075-0', 'ovn-1037', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cl-' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cl-' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Cl-(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cl-(Huyết thanh)' ), 'N', NULL, now(), 400, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cl-(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 98.00, 106.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Electrolytes' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cl-(Huyết thanh)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Calcium.total', '', 'Ca Total', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Calcium.total', '', 'Ca Total', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mEq/l' ), 'Ca Total(Huyết thanh)', 'Ca Total', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1038', 370, 'Ca Total', '2000-8', 'ovn-1038', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ca Total' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ca Total' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca Total(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca Total(Huyết thanh)' ), 'N', NULL, now(), 410, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca Total(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 4.00, 4.50);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Electrolytes' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ca Total(Huyết thanh)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bicarbonate', '', 'HCO3-', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bicarbonate', '', 'HCO3-', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mEq/l' ), 'HCO3-(Huyết thanh)', 'HCO3-', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1039', 380, 'HCO3-', '1963-8', 'ovn-1039', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HCO3-' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HCO3-' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'HCO3-(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HCO3-(Huyết thanh)' ), 'N', NULL, now(), 420, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HCO3-(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 24.00, 29.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Electrolytes' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'HCO3-(Huyết thanh)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Magnesium', '', 'Magnesium', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Magnesium', '', 'Magnesium', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/l' ), 'Magnesium(Huyết thanh)', 'Magnesium', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1040', 390, 'Magnesium', '19123-9', 'ovn-1040', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Magnesium' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Magnesium' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Magnesium(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Magnesium(Huyết thanh)' ), 'N', NULL, now(), 430, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Magnesium(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 25.00, 40.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Phosphorus', '', 'Phosphore', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Phosphorus', '', 'Phosphore', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/l' ), 'Phosphore(Huyết thanh)', 'Phosphore', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1041', 400, 'Phosphore', '2777-1', 'ovn-1041', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Phosphore' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Phosphore' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Phosphore(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Phosphore(Huyết thanh)' ), 'N', NULL, now(), 440, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Phosphore(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 40.00, 70.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Amylase', '', 'Amylase - Blood', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Amylase', '', 'Amylase - Blood', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'Amylase - Blood(Huyết thanh)', 'Amylase - Blood', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1042', 410, 'Amylase - Blood', '1798-8', 'ovn-1042', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Amylase - Blood' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Amylase - Blood' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Amylase - Blood(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amylase - Blood(Huyết thanh)' ), 'N', NULL, now(), 450, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amylase - Blood(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 82.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lipase, blood', '', 'Lipase - Blood', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lipase, blood', '', 'Lipase - Blood', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'Lipase - Blood(Huyết thanh)', 'Lipase - Blood', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1043', 420, 'Lipase - Blood', '3040-3', 'ovn-1043', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Lipase - Blood' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Lipase - Blood' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Lipase - Blood(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lipase - Blood(Huyết thanh)' ), 'N', NULL, now(), 460, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lipase - Blood(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 7.00, 60.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Glucose', '', 'Glycemie', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Glucose', '', 'Glycemie', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Glycemie(Huyết thanh)', 'Glycemie', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1044', 430, 'Glycemie', '2345-7', 'ovn-1044', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Glycemie' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Glycemie' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Glycemie(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Glycemie(Huyết thanh)' ), 'N', NULL, now(), 470, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Glycemie(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.80, 1.20);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lactate', '', 'Lactate', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lactate', '', 'Lactate', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmol/l' ), 'Lactate(Huyết thanh)', 'Lactate', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1045', 440, 'Lactate', '2524-7', 'ovn-1045', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Lactate' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Lactate' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Lactate(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lactate(Huyết thanh)' ), 'N', NULL, now(), 480, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lactate(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 1.80, 2.70);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Creatine kinase', '', 'CPK', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Creatine kinase', '', 'CPK', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'CPK(Huyết thanh)', 'CPK', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1046', 450, 'CPK', '2157-6', 'ovn-1046', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CPK' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CPK' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'CPK(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CPK(Huyết thanh)' ), 'N', NULL, now(), 490, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CPK(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 230.00);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'ug/l', 'ug/l', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Creatine kinase.MB', '', 'CK-MB', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Creatine kinase.MB', '', 'CK-MB', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ug/l' ), 'CK-MB(Huyết thanh)', 'CK-MB', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1047', 460, 'CK-MB', '13969-1', 'ovn-1047', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CK-MB' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CK-MB' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'CK-MB(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CK-MB(Huyết thanh)' ), 'N', NULL, now(), 500, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CK-MB(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 3.40, 6.60);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lactate dehydrogenase', '', 'LDH', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lactate dehydrogenase', '', 'LDH', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'LDH(Huyết thanh)', 'LDH', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1048', 470, 'LDH', '14804-9', 'ovn-1048', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'LDH' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'LDH' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'LDH(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LDH(Huyết thanh)' ), 'N', NULL, now(), 510, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LDH(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 100.00, 250.00);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'ng/ml', 'ng/ml', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Troponin I', '', 'Troponin I', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Troponin I', '', 'Troponin I', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/ml' ), 'Troponin I(Huyết thanh)', 'Troponin I', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1049', 480, 'Troponin I', '10839-9', 'ovn-1049', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Troponin I' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Troponin I' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Troponin I(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Troponin I(Huyết thanh)' ), 'N', NULL, now(), 520, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Troponin I(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 0.04);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Uric acid', '', 'Acid Uric', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Uric acid', '', 'Acid Uric', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/l' ), 'Acid Uric(Huyết thanh)', 'Acid Uric', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1050', 490, 'Acid Uric', '3084-1', 'ovn-1050', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Acid Uric' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Acid Uric' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Acid Uric(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Acid Uric(Huyết thanh)' ), 'N', NULL, now(), 530, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Acid Uric(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 70.00);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'UI/ml', 'UI/ml', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Rheumatoid factor', '', 'RF', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Rheumatoid factor', '', 'RF', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UI/ml' ), 'RF(Huyết thanh)', 'RF', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1051', 500, 'RF', '11572-5', 'ovn-1051', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'RF' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'RF' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'RF(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'RF(Huyết thanh)' ), 'N', NULL, now(), 540, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'RF(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 20.00);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mg/dl', 'mg/dl', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Complement C3', '', 'Complement C3', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Complement C3', '', 'Complement C3', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/dl' ), 'Complement C3(Huyết thanh)', 'Complement C3', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1052', 510, 'Complement C3', '4485-9', 'ovn-1052', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Complement C3' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Complement C3' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Complement C3(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Complement C3(Huyết thanh)' ), 'N', NULL, now(), 550, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Complement C3(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 83.00, 170.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Complement C4', '', 'Complement C4', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Complement C4', '', 'Complement C4', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/dl' ), 'Complement C4(Huyết thanh)', 'Complement C4', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1053', 520, 'Complement C4', '4498-2', 'ovn-1053', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Complement C4' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Complement C4' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Complement C4(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Complement C4(Huyết thanh)' ), 'N', NULL, now(), 560, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Complement C4(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 19.00, 59.00);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'g/L', 'g/L', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'IgA', '', 'IgA', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'IgA', '', 'IgA', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/L' ), 'IgA(Huyết thanh)', 'IgA', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1054', 530, 'IgA', '2458-8', 'ovn-1054', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'IgA' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'IgA' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'IgA(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'IgA(Huyết thanh)' ), 'N', NULL, now(), 570, 1, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'IgA(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.7, 4.0);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'IgG', '', 'IgG', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'IgG', '', 'IgG', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/L' ), 'IgG(Huyết thanh)', 'IgG', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1055', 540, 'IgG', '2465-3', 'ovn-1055', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'IgG' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'IgG' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'IgG(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'IgG(Huyết thanh)' ), 'N', NULL, now(), 580, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'IgG(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 7, 16);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'IgM', '', 'IgM', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'IgM', '', 'IgM', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/L' ), 'IgM(Huyết thanh)', 'IgM', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1056', 550, 'IgM', '2472-9', 'ovn-1056', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'IgM' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'IgM' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'IgM(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'IgM(Huyết thanh)' ), 'N', NULL, now(), 590, 1, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'IgM(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.4, 2.3);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'Umol/l', 'Umol/l', now());
INSERT INTO clinlims.type_of_sample ( id, description, domain, lastupdated, local_abbrev, display_key, sort_order, is_active ) VALUES
	( nextval( 'type_of_sample_seq' ), 'Huyết tương', 'H', now(), 'Huyết tươn', 'sample.type.plasma', 50, 'Y');
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ammonia', '', 'NH3', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ammonia', '', 'NH3', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'Umol/l' ), 'NH3(Huyết tương)', 'NH3', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1057', 560, 'NH3', '16362-6', 'ovn-1057', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'NH3' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'NH3' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết tương' ), ( SELECT id FROM clinlims.test WHERE description = 'NH3(Huyết tương)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'NH3(Huyết tương)' ), 'N', NULL, now(), 600, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'NH3(Huyết tương)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 11.00, 35.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Globulin', '', 'Globulin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Globulin', '', 'Globulin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Globulin(Huyết thanh)', 'Globulin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1063', 570, 'Globulin', '2336-6', 'ovn-1063', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Globulin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Globulin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Globulin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Globulin(Huyết thanh)' ), 'N', NULL, now(), 610, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Globulin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 28.00, 38.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Albumin/Globulin', '', 'A/G', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Albumin/Globulin', '', 'A/G', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'A/G(Huyết thanh)', 'A/G', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1064', 580, 'A/G', '1759-0', 'ovn-1064', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'A/G' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'A/G' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'A/G(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'A/G(Huyết thanh)' ), 'N', NULL, now(), 620, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'A/G(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 1.30, 1.80);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'U/L', 'U/L', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Creatine kinase', '', 'CK', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Creatine kinase', '', 'CK', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'U/L' ), 'CK(Huyết thanh)', 'CK', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1065', 590, 'CK', '2157-6', 'ovn-1065', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CK' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CK' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'CK(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CK(Huyết thanh)' ), 'N', NULL, now(), 630, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CK(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 24.00, 190.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Alkaline phosphatase', '', 'Phosphatase kiềm', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Alkaline phosphatase', '', 'Phosphatase kiềm', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'U/L' ), 'Phosphatase kiềm(Huyết thanh)', 'Phosphatase kiềm', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1066', 600, 'Phosphatase kiềm', '6768-6', 'ovn-1066', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Phosphatase kiềm' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Phosphatase kiềm' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Phosphatase kiềm(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Phosphatase kiềm(Huyết thanh)' ), 'N', NULL, now(), 640, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Phosphatase kiềm(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 30.00, 117.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Catecholamines', '', 'Catecholamin Máu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Catecholamines', '', 'Catecholamin Máu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Catecholamin Máu(Huyết tương)', 'Catecholamin Máu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1067', 610, 'Catecholamin Máu', '2056-0', 'ovn-1067', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Catecholamin Máu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Catecholamin Máu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết tương' ), ( SELECT id FROM clinlims.test WHERE description = 'Catecholamin Máu(Huyết tương)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Catecholamin Máu(Huyết tương)' ), 'N', NULL, now(), 650, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Catecholamin Máu(Huyết tương)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), '%', '%', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Alpha 1 globulin/Protein.total', '', 'Alpha1 globulin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Alpha 1 globulin/Protein.total', '', 'Alpha1 globulin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Alpha1 globulin(Huyết thanh)', 'Alpha1 globulin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1068', 620, 'Alpha1 globulin', '13978-2', 'ovn-1068', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Alpha1 globulin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Alpha1 globulin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Alpha1 globulin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Alpha1 globulin(Huyết thanh)' ), 'N', NULL, now(), 660, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Alpha1 globulin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 5.00, 8.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Alpha 2 globulin/Protein.total', '', 'Alpha 2 globulin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Alpha 2 globulin/Protein.total', '', 'Alpha 2 globulin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Alpha 2 globulin(Huyết thanh)', 'Alpha 2 globulin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1069', 630, 'Alpha 2 globulin', '13981-6', 'ovn-1069', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Alpha 2 globulin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Alpha 2 globulin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Alpha 2 globulin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Alpha 2 globulin(Huyết thanh)' ), 'N', NULL, now(), 670, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Alpha 2 globulin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 8.00, 15.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Beta 1 globulin/Protein.total', '', 'Beta 1 globulin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Beta 1 globulin/Protein.total', '', 'Beta 1 globulin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Beta 1 globulin(Huyết thanh)', 'Beta 1 globulin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1070', 640, 'Beta 1 globulin', '32732-0', 'ovn-1070', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Beta 1 globulin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Beta 1 globulin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Beta 1 globulin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Beta 1 globulin(Huyết thanh)' ), 'N', NULL, now(), 680, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Beta 1 globulin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 4.70, 7.20);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Beta 2 globulin/Protein.total', '', 'Beta 2 globulin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Beta 2 globulin/Protein.total', '', 'Beta 2 globulin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Beta 2 globulin(Huyết thanh)', 'Beta 2 globulin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1071', 650, 'Beta 2 globulin', '32733-8', 'ovn-1071', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Beta 2 globulin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Beta 2 globulin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Beta 2 globulin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Beta 2 globulin(Huyết thanh)' ), 'N', NULL, now(), 690, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Beta 2 globulin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 3.20, 6.50);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Gamma globulin/Protein.total', '', 'Gamma globulin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Gamma globulin/Protein.total', '', 'Gamma globulin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Gamma globulin(Huyết thanh)', 'Gamma globulin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1072', 660, 'Gamma globulin', '13983-2', 'ovn-1072', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Gamma globulin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Gamma globulin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Gamma globulin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gamma globulin(Huyết thanh)' ), 'N', NULL, now(), 700, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gamma globulin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 15.00, 25.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Albumin/Protein.total electrophoresis', '', 'Albumin điện di đạm', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Albumin/Protein.total electrophoresis', '', 'Albumin điện di đạm', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Albumin điện di đạm(Huyết thanh)', 'Albumin điện di đạm', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1073', 670, 'Albumin điện di đạm', '13980-8', 'ovn-1073', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Albumin điện di đạm' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Albumin điện di đạm' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Albumin điện di đạm(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Albumin điện di đạm(Huyết thanh)' ), 'N', NULL, now(), 710, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Albumin điện di đạm(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 50.00, 60.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Total protein electrophoresis', '', 'Total protein điện di đạm', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Total protein electrophoresis', '', 'Total protein điện di đạm', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Total protein điện di đạm(Huyết thanh)', 'Total protein điện di đạm', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1074', 680, 'Total protein điện di đạm', '2885-2', 'ovn-1074', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Total protein điện di đạm' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Total protein điện di đạm' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Total protein điện di đạm(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Total protein điện di đạm(Huyết thanh)' ), 'N', NULL, now(), 720, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Total protein điện di đạm(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.type_of_sample ( id, description, domain, lastupdated, local_abbrev, display_key, sort_order, is_active ) VALUES
	( nextval( 'type_of_sample_seq' ), 'Máu', 'H', now(), 'Máu', 'sample.type.blood', 60, 'Y');
INSERT INTO clinlims.panel ( id, name, description, lastupdated, display_key, sort_order ) VALUES
	( nextval( 'panel_seq' ), 'Blood gas', 'Blood gas', now(), 'panel.name.blood.gas', 20);
INSERT INTO clinlims.sampletype_panel ( id, sample_type_id, panel_id ) VALUES
	( nextval( 'sample_type_panel_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'C', 'C', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Temperature', '', 'Nhiệt độ GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Temperature', '', 'Nhiệt độ GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'C' ), 'Nhiệt độ GDS(Máu)', 'Nhiệt độ GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1076', 690, 'Nhiệt độ GDS', '8310-5', 'ovn-1076', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Nhiệt độ GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Nhiệt độ GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhiệt độ GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhiệt độ GDS(Máu)' ), 'N', NULL, now(), 730, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhiệt độ GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 37.00, 37.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Nhiệt độ GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'pH (blood gas panel)', '', 'pH GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'pH (blood gas panel)', '', 'pH GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'pH GDS(Máu)', 'pH GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1077', 700, 'pH GDS', '11558-4', 'ovn-1077', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'pH GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'pH GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'pH GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'pH GDS(Máu)' ), 'N', NULL, now(), 740, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'pH GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 7.36, 7.44);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'pH GDS(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mmHg', 'mmHg', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'pCO2 (blood gas panel)', '', 'pCO2 GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'pCO2 (blood gas panel)', '', 'pCO2 GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmHg' ), 'pCO2 GDS(Máu)', 'pCO2 GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1078', 710, 'pCO2 GDS', '11557-6', 'ovn-1078', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'pCO2 GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'pCO2 GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'pCO2 GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'pCO2 GDS(Máu)' ), 'N', NULL, now(), 750, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'pCO2 GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 36.00, 44.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'pCO2 GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'pO2 (blood gas panel)', '', 'pO2 GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'pO2 (blood gas panel)', '', 'pO2 GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmHg' ), 'pO2 GDS(Máu)', 'pO2 GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1079', 720, 'pO2 GDS', '11556-8', 'ovn-1079', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'pO2 GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'pO2 GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'pO2 GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'pO2 GDS(Máu)' ), 'N', NULL, now(), 760, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'pO2 GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 80.00, 100.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'pO2 GDS(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mmol/L', 'mmol/L', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Base excess (blood gas panel)', '', 'BE GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Base excess (blood gas panel)', '', 'BE GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmol/L' ), 'BE GDS(Máu)', 'BE GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1080', 730, 'BE GDS', '11555-0', 'ovn-1080', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'BE GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'BE GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'BE GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'BE GDS(Máu)' ), 'N', NULL, now(), 770, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'BE GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), -4.00, 4.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'BE GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Total CO2 (blood gas panel)', '', 'tCO2 GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Total CO2 (blood gas panel)', '', 'tCO2 GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmol/L' ), 'tCO2 GDS(Máu)', 'tCO2 GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1081', 740, 'tCO2 GDS', '20565-8', 'ovn-1081', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'tCO2 GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'tCO2 GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'tCO2 GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'tCO2 GDS(Máu)' ), 'N', NULL, now(), 780, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'tCO2 GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'tCO2 GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'HCO3 (blood gas panel)', '', 'HCO3 GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'HCO3 (blood gas panel)', '', 'HCO3 GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmol/L' ), 'HCO3 GDS(Máu)', 'HCO3 GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1082', 750, 'HCO3 GDS', '1959-6', 'ovn-1082', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HCO3 GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HCO3 GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HCO3 GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HCO3 GDS(Máu)' ), 'N', NULL, now(), 790, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HCO3 GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 22.00, 26.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'HCO3 GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'O2 Sat (blood gas panel)', '', 'SO2 GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'O2 Sat (blood gas panel)', '', 'SO2 GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'SO2 GDS(Máu)', 'SO2 GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1083', 760, 'SO2 GDS', '2713-6', 'ovn-1083', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'SO2 GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'SO2 GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'SO2 GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'SO2 GDS(Máu)' ), 'N', NULL, now(), 800, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'SO2 GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 92.00, 96.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'SO2 GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'A-a O2 difference (blood gas panel)', '', 'AaDO2 GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'A-a O2 difference (blood gas panel)', '', 'AaDO2 GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmHg' ), 'AaDO2 GDS(Máu)', 'AaDO2 GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1084', 770, 'AaDO2 GDS', '19991-9', 'ovn-1084', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'AaDO2 GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'AaDO2 GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'AaDO2 GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'AaDO2 GDS(Máu)' ), 'N', NULL, now(), 810, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'AaDO2 GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'AaDO2 GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'FiO2 (blood gas panel)', '', 'FiO2 GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'FiO2 (blood gas panel)', '', 'FiO2 GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'FiO2 GDS(Máu)', 'FiO2 GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1085', 780, 'FiO2 GDS', '19994-3', 'ovn-1085', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'FiO2 GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'FiO2 GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'FiO2 GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'FiO2 GDS(Máu)' ), 'N', NULL, now(), 820, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'FiO2 GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'FiO2 GDS(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'g/dl', 'g/dl', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin (blood gas panel)', '', 'Hb GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin (blood gas panel)', '', 'Hb GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/dl' ), 'Hb GDS(Máu)', 'Hb GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1086', 790, 'Hb GDS', '718-7', 'ovn-1086', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Hb GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Hb GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Hb GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hb GDS(Máu)' ), 'N', NULL, now(), 830, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hb GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Hb GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'P50 (blood gas panel)', '', 'P50 GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'P50 (blood gas panel)', '', 'P50 GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'P50 GDS(Máu)', 'P50 GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1087', 800, 'P50 GDS', '65343-6', 'ovn-1087', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'P50 GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'P50 GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'P50 GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'P50 GDS(Máu)' ), 'N', NULL, now(), 840, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'P50 GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'P50 GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Na+ (blood gas panel)', '', 'Na+ GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Na+ (blood gas panel)', '', 'Na+ GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmol/L' ), 'Na+ GDS(Máu)', 'Na+ GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1088', 810, 'Na+ GDS', '2947-0', 'ovn-1088', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Na+ GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Na+ GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Na+ GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Na+ GDS(Máu)' ), 'N', NULL, now(), 850, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Na+ GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 135.00, 145.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Na+ GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'K+ (blood gas panel)', '', 'K+ GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'K+ (blood gas panel)', '', 'K+ GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmol/L' ), 'K+ GDS(Máu)', 'K+ GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1089', 820, 'K+ GDS', '6298-4', 'ovn-1089', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'K+ GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'K+ GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'K+ GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'K+ GDS(Máu)' ), 'N', NULL, now(), 860, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'K+ GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 3.50, 5.10);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'K+ GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ca++ (blood gas panel)', '', 'Ca++ GDS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ca++ (blood gas panel)', '', 'Ca++ GDS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mmol/L' ), 'Ca++ GDS(Máu)', 'Ca++ GDS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1090', 830, 'Ca++ GDS', '1994-3', 'ovn-1090', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ca++ GDS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ca++ GDS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca++ GDS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca++ GDS(Máu)' ), 'N', NULL, now(), 870, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca++ GDS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 1.12, 1.32);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood gas' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ca++ GDS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin A', '', 'HbA', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin A', '', 'HbA', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'HbA(Máu)', 'HbA', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1091', 840, 'HbA', '4546-8', 'ovn-1091', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HbA' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HbA' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HbA(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbA(Máu)' ), 'N', NULL, now(), 880, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbA(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 95.00, 98.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin A2', '', 'HbA2', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin A2', '', 'HbA2', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'HbA2(Máu)', 'HbA2', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1092', 850, 'HbA2', '4551-8', 'ovn-1092', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HbA2' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HbA2' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HbA2(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbA2(Máu)' ), 'N', NULL, now(), 890, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbA2(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 2.00, 3.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin F', '', 'HbF', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin F', '', 'HbF', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'HbF(Máu)', 'HbF', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1093', 860, 'HbF', '4576-5', 'ovn-1093', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HbF' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HbF' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HbF(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbF(Máu)' ), 'N', NULL, now(), 900, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbF(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 2.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin Barts', '', 'Hb Bart''s', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin Barts', '', 'Hb Bart''s', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Hb Bart''s(Máu)', 'Hb Bart''s', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1094', 870, 'Hb Bart''s', '31156-3', 'ovn-1094', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Hb Bart''s' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Hb Bart''s' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Hb Bart''s(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hb Bart''s(Máu)' ), 'N', NULL, now(), 910, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hb Bart''s(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin C', '', 'HbC', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin C', '', 'HbC', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'HbC(Máu)', 'HbC', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1095', 880, 'HbC', '4563-3', 'ovn-1095', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HbC' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HbC' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HbC(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbC(Máu)' ), 'N', NULL, now(), 920, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbC(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin D', '', 'HbD', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin D', '', 'HbD', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'HbD(Máu)', 'HbD', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1096', 890, 'HbD', '4569-0', 'ovn-1096', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HbD' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HbD' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HbD(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbD(Máu)' ), 'N', NULL, now(), 930, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbD(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin E', '', 'HbE', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin E', '', 'HbE', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'HbE(Máu)', 'HbE', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1097', 900, 'HbE', '4575-7', 'ovn-1097', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HbE' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HbE' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HbE(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbE(Máu)' ), 'N', NULL, now(), 940, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbE(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin H', '', 'HbH', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin H', '', 'HbH', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'HbH(Máu)', 'HbH', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1098', 910, 'HbH', '4588-0', 'ovn-1098', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HbH' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HbH' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HbH(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbH(Máu)' ), 'N', NULL, now(), 950, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbH(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin S', '', 'HbS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin S', '', 'HbS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'HbS(Máu)', 'HbS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1099', 920, 'HbS', '4625-0', 'ovn-1099', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HbS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HbS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HbS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbS(Máu)' ), 'N', NULL, now(), 960, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HbS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Streptolysin O Ab', '', 'ASO', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Streptolysin O Ab', '', 'ASO', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'ASO(Huyết thanh)', 'ASO', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1100', 930, 'ASO', '5370-2', 'ovn-1100', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'ASO' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'ASO' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'ASO(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'ASO(Huyết thanh)' ), 'N', NULL, now(), 970, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'ASO(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.type_of_sample ( id, description, domain, lastupdated, local_abbrev, display_key, sort_order, is_active ) VALUES
	( nextval( 'type_of_sample_seq' ), 'Nước tiểu', 'H', now(), 'Nước tiểu', 'sample.type.urine', 70, 'Y');
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Uric acid', '', 'Acid Uric', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Uric acid', '', 'Acid Uric', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Acid Uric(Nước tiểu)', 'Acid Uric', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1101', 940, 'Acid Uric', '21587-1', 'ovn-1101', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Acid Uric' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Acid Uric' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Acid Uric(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Acid Uric(Nước tiểu)' ), 'N', NULL, now(), 980, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Acid Uric(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '+', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '+++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '++++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Vết', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Blood', '', 'Blood', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Blood', '', 'Blood', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Blood(Nước tiểu)', 'Blood', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1102', 950, 'Blood', '53292-9', 'ovn-1102', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Blood' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Blood' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Blood(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Blood(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 990, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Blood(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 1000, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Blood(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 1010, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Blood(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 1020, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Blood(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 1030, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Blood(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Vết' ), now(), 1040, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Potassium', '', 'K+', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Potassium', '', 'K+', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'K+(Nước tiểu)', 'K+', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1103', 960, 'K+', '21476-7', 'ovn-1103', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'K+' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'K+' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'K+(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'K+(Nước tiểu)' ), 'N', NULL, now(), 1060, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'K+(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Sodium, urine', '', 'Na+', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Sodium, urine', '', 'Na+', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Na+(Nước tiểu)', 'Na+', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1104', 970, 'Na+', '21525-1', 'ovn-1104', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Na+' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Na+' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Na+(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Na+(Nước tiểu)' ), 'N', NULL, now(), 1070, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Na+(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Calcium++', '', 'Ca++', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Calcium++', '', 'Ca++', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ca++(Nước tiểu)', 'Ca++', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1105', 980, 'Ca++', '25362-5', 'ovn-1105', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ca++' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ca++' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca++(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca++(Nước tiểu)' ), 'N', NULL, now(), 1080, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca++(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mEq', 'mEq', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Calcium.Total, urine', '', 'Ca TP niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Calcium.Total, urine', '', 'Ca TP niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mEq' ), 'Ca TP niệu(Nước tiểu)', 'Ca TP niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1106', 990, 'Ca TP niệu', '32541-5', 'ovn-1106', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ca TP niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ca TP niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca TP niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca TP niệu(Nước tiểu)' ), 'N', NULL, now(), 1090, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ca TP niệu(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Chloride', '', 'Cl-', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Chloride', '', 'Cl-', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cl-(Nước tiểu)', 'Cl-', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1107', 1000, 'Cl-', '21194-6', 'ovn-1107', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cl-' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cl-' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Cl-(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cl-(Nước tiểu)' ), 'N', NULL, now(), 1100, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cl-(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bilirubin', '', 'BILIRUBIN', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bilirubin', '', 'BILIRUBIN', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'BILIRUBIN(Nước tiểu)', 'BILIRUBIN', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1108', 1010, 'BILIRUBIN', '1977-8', 'ovn-1108', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'BILIRUBIN' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'BILIRUBIN' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'BILIRUBIN(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'BILIRUBIN(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 1110, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'BILIRUBIN(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 1120, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'BILIRUBIN(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 1130, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'BILIRUBIN(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 1140, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'BILIRUBIN(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 1150, NULL, false);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'umol', 'umol', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Urobilinogen, urine', '', 'UROBILINOGENE', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Urobilinogen, urine', '', 'UROBILINOGENE', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'umol' ), 'UROBILINOGENE(Nước tiểu)', 'UROBILINOGENE', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1109', 1020, 'UROBILINOGENE', '60025-4', 'ovn-1109', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'UROBILINOGENE' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'UROBILINOGENE' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'UROBILINOGENE(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'UROBILINOGENE(Nước tiểu)' ), 'N', NULL, now(), 1170, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'UROBILINOGENE(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ketones', '', 'KET', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ketones', '', 'KET', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'KET(Nước tiểu)', 'KET', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1110', 1030, 'KET', '2514-8', 'ovn-1110', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'KET' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'KET' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'KET(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'KET(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 1180, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'KET(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 1190, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'KET(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 1200, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'KET(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 1210, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'KET(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 1220, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Glucose', '', 'GLUCOSE', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Glucose', '', 'GLUCOSE', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'GLUCOSE(Nước tiểu)', 'GLUCOSE', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1111', 1040, 'GLUCOSE', '50555-2', 'ovn-1111', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'GLUCOSE' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'GLUCOSE' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'GLUCOSE(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'GLUCOSE(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 1240, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'GLUCOSE(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 1250, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'GLUCOSE(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 1260, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'GLUCOSE(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 1270, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'GLUCOSE(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 1280, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Protein', '', 'PROTEIN', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Protein', '', 'PROTEIN', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'PROTEIN(Nước tiểu)', 'PROTEIN', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1112', 1050, 'PROTEIN', '2888-6', 'ovn-1112', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'PROTEIN' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'PROTEIN' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'PROTEIN(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PROTEIN(Nước tiểu)' ), 'N', NULL, now(), 1300, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PROTEIN(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'ph, urine', '', 'pH', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'ph, urine', '', 'pH', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'pH(Nước tiểu)', 'pH', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1113', 1060, 'pH', '2756-5', 'ovn-1113', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'pH' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'pH' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'pH(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'pH(Nước tiểu)' ), 'N', NULL, now(), 1310, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'pH(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Nitrite', '', 'NITRIC', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Nitrite', '', 'NITRIC', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'NITRIC(Nước tiểu)', 'NITRIC', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1114', 1070, 'NITRIC', '32710-6', 'ovn-1114', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'NITRIC' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'NITRIC' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'NITRIC(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'NITRIC(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 1320, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'NITRIC(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 1330, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'NITRIC(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 1340, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'NITRIC(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 1350, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'NITRIC(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 1360, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Leukocytes', '', 'LEUCOCYTE', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Leukocytes', '', 'LEUCOCYTE', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'LEUCOCYTE(Nước tiểu)', 'LEUCOCYTE', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1115', 1080, 'LEUCOCYTE', '33052-2', 'ovn-1115', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'LEUCOCYTE' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'LEUCOCYTE' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'LEUCOCYTE(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LEUCOCYTE(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 1380, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LEUCOCYTE(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 1390, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LEUCOCYTE(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 1400, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LEUCOCYTE(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 1410, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LEUCOCYTE(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 1420, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Specific gravity', '', 'SG', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Specific gravity', '', 'SG', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'SG(Nước tiểu)', 'SG', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1116', 1090, 'SG', '2965-2', 'ovn-1116', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'SG' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'SG' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'SG(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'SG(Nước tiểu)' ), 'N', NULL, now(), 1440, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'SG(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Magnesium, urine', '', 'Magie niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Magnesium, urine', '', 'Magie niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/l' ), 'Magie niệu(Nước tiểu)', 'Magie niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1117', 1100, 'Magie niệu', '32024-2', 'ovn-1117', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Magie niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Magie niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Magie niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Magie niệu(Nước tiểu)' ), 'N', NULL, now(), 1450, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Magie niệu(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Urea, urine', '', 'Uree niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Urea, urine', '', 'Uree niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Uree niệu(Nước tiểu)', 'Uree niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1118', 1110, 'Uree niệu', '3095-7', 'ovn-1118', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Uree niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Uree niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Uree niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Uree niệu(Nước tiểu)' ), 'N', NULL, now(), 1460, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Uree niệu(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Creatinine, urine', '', 'Creat niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Creatinine, urine', '', 'Creat niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Creat niệu(Nước tiểu)', 'Creat niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1119', 1120, 'Creat niệu', '2161-8', 'ovn-1119', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Creat niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Creat niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Creat niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Creat niệu(Nước tiểu)' ), 'N', NULL, now(), 1470, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Creat niệu(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Amylase, urine', '', 'Amylase niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Amylase, urine', '', 'Amylase niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'Amylase niệu(Nước tiểu)', 'Amylase niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1120', 1130, 'Amylase niệu', '1799-6', 'ovn-1120', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Amylase niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Amylase niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Amylase niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amylase niệu(Nước tiểu)' ), 'N', NULL, now(), 1480, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amylase niệu(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 320.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lipase, urine', '', 'Lipase niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lipase, urine', '', 'Lipase niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'UL' ), 'Lipase niệu(Nước tiểu)', 'Lipase niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1121', 1140, 'Lipase niệu', '10888-6', 'ovn-1121', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Lipase niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Lipase niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Lipase niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lipase niệu(Nước tiểu)' ), 'N', NULL, now(), 1490, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lipase niệu(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mg', 'mg', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Phosphorus, urine', '', 'P niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Phosphorus, urine', '', 'P niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg' ), 'P niệu(Nước tiểu)', 'P niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1122', 1150, 'P niệu', '2779-7', 'ovn-1122', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'P niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'P niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'P niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'P niệu(Nước tiểu)' ), 'N', NULL, now(), 1500, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'P niệu(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bilirubin', '', 'Sắt Sắc tố mật niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bilirubin', '', 'Sắt Sắc tố mật niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Sắt Sắc tố mật niệu(Nước tiểu)', 'Sắt Sắc tố mật niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1123', 1160, 'Sắt Sắc tố mật niệu', '5770-3', 'ovn-1123', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Sắt Sắc tố mật niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Sắt Sắc tố mật niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắt Sắc tố mật niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắt Sắc tố mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 1510, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắt Sắc tố mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 1520, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắt Sắc tố mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 1530, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắt Sắc tố mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 1540, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắt Sắc tố mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 1550, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắt Sắc tố mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Vết' ), now(), 1560, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bile salt, urine', '', 'Muối mật niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bile salt, urine', '', 'Muối mật niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Muối mật niệu(Nước tiểu)', 'Muối mật niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1124', 1170, 'Muối mật niệu', '43889-5', 'ovn-1124', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Muối mật niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Muối mật niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Muối mật niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Muối mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 1580, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Muối mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 1590, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Muối mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 1600, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Muối mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 1610, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Muối mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 1620, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Muối mật niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Vết' ), now(), 1630, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Blood, urine', '', 'Máu niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Blood, urine', '', 'Máu niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Máu niệu(Nước tiểu)', 'Máu niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1125', 1180, 'Máu niệu', '33051-4', 'ovn-1125', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Máu niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Máu niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 1650, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 1660, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 1670, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 1680, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 1690, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Vết' ), now(), 1700, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin, urine', '', 'Hb niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin, urine', '', 'Hb niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Hb niệu(Nước tiểu)', 'Hb niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1126', 1190, 'Hb niệu', '725-2', 'ovn-1126', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Hb niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Hb niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Hb niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hb niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 1720, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hb niệu(Nước tiểu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 1730, NULL, false);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'g/24h', 'g/24h', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Urea, 24h urine', '', 'Uree niệu 24h', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Urea, 24h urine', '', 'Uree niệu 24h', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/24h' ), 'Uree niệu 24h(Nước tiểu)', 'Uree niệu 24h', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1127', 1200, 'Uree niệu 24h', '3096-5', 'ovn-1127', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Uree niệu 24h' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Uree niệu 24h' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Uree niệu 24h(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Uree niệu 24h(Nước tiểu)' ), 'N', NULL, now(), 1750, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Uree niệu 24h(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mg/24h', 'mg/24h', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Creatinine, 24h urine', '', 'Creat niệu 24h', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Creatinine, 24h urine', '', 'Creat niệu 24h', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/24h' ), 'Creat niệu 24h(Nước tiểu)', 'Creat niệu 24h', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1128', 1210, 'Creat niệu 24h', '2162-6', 'ovn-1128', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Creat niệu 24h' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Creat niệu 24h' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Creat niệu 24h(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Creat niệu 24h(Nước tiểu)' ), 'N', NULL, now(), 1760, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Creat niệu 24h(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Protein, urine', '', 'Protein niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Protein, urine', '', 'Protein niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Protein niệu(Nước tiểu)', 'Protein niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1129', 1220, 'Protein niệu', '2888-6', 'ovn-1129', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Protein niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Protein niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein niệu(Nước tiểu)' ), 'N', NULL, now(), 1770, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein niệu(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Glucose, urine', '', 'Glucose niệu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Glucose, urine', '', 'Glucose niệu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Glucose niệu(Nước tiểu)', 'Glucose niệu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1130', 1230, 'Glucose niệu', '5792-7', 'ovn-1130', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Glucose niệu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Glucose niệu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Glucose niệu(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Glucose niệu(Nước tiểu)' ), 'N', NULL, now(), 1780, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Glucose niệu(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Protein, 24h urine', '', 'Protein niệu 24h', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Protein, 24h urine', '', 'Protein niệu 24h', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/24h' ), 'Protein niệu 24h(Nước tiểu)', 'Protein niệu 24h', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1131', 1240, 'Protein niệu 24h', '2889-4', 'ovn-1131', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Protein niệu 24h' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Protein niệu 24h' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein niệu 24h(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein niệu 24h(Nước tiểu)' ), 'N', NULL, now(), 1790, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Protein niệu 24h(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'ml', 'ml', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Specimen volume, 24h urine', '', 'Thể tích nước tiểu 24h', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Specimen volume, 24h urine', '', 'Thể tích nước tiểu 24h', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ml' ), 'Thể tích nước tiểu 24h(Nước tiểu)', 'Thể tích nước tiểu 24h', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Biochemistry' ), 'ovn-1132', 1250, 'Thể tích nước tiểu 24h', '3167-4', 'ovn-1132', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Thể tích nước tiểu 24h' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Thể tích nước tiểu 24h' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Nước tiểu' ), ( SELECT id FROM clinlims.test WHERE description = 'Thể tích nước tiểu 24h(Nước tiểu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Thể tích nước tiểu 24h(Nước tiểu)' ), 'N', NULL, now(), 1800, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Thể tích nước tiểu 24h(Nước tiểu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.test_section ( id, name, description, is_external, lastupdated, display_key, sort_order, is_active ) VALUES
	( nextval( 'test_section_seq' ), 'Immunology', 'Immunology', 'N', now(), 'test.section.immunology', 20, 'Y');
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'ug/dl', 'ug/dl', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Iron, serum', '', 'Sắt huyết thanh', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Iron, serum', '', 'Sắt huyết thanh', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ug/dl' ), 'Sắt huyết thanh(Huyết thanh)', 'Sắt huyết thanh', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1133', 1260, 'Sắt huyết thanh', '2498-4', 'ovn-1133', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Sắt huyết thanh' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Sắt huyết thanh' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắt huyết thanh(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắt huyết thanh(Huyết thanh)' ), 'N', NULL, now(), 1810, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắt huyết thanh(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 35.00, 155.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ferritin', '', 'Ferritin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ferritin', '', 'Ferritin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/ml' ), 'Ferritin(Huyết thanh)', 'Ferritin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1134', 1270, 'Ferritin', '2276-4', 'ovn-1134', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ferritin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ferritin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Ferritin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ferritin(Huyết thanh)' ), 'N', NULL, now(), 1820, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ferritin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 15.00, 120.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Vitamin B12', '', 'B12', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Vitamin B12', '', 'B12', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'B12(Huyết thanh)', 'B12', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1135', 1280, 'B12', '2132-9', 'ovn-1135', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'B12' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'B12' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'B12(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'B12(Huyết thanh)' ), 'N', NULL, now(), 1830, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'B12(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Transferrin', '', 'Transferrin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Transferrin', '', 'Transferrin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mg/dl' ), 'Transferrin(Huyết thanh)', 'Transferrin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1136', 1290, 'Transferrin', '3034-6', 'ovn-1136', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Transferrin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Transferrin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Transferrin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Transferrin(Huyết thanh)' ), 'N', NULL, now(), 1840, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Transferrin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 200.00, 360.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Transferrin saturation', '', 'TRF sat', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Transferrin saturation', '', 'TRF sat', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'TRF sat(Huyết thanh)', 'TRF sat', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1137', 1300, 'TRF sat', '2502-3', 'ovn-1137', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'TRF sat' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'TRF sat' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'TRF sat(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TRF sat(Huyết thanh)' ), 'N', NULL, now(), 1850, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TRF sat(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 20.00, 50.00);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mcg/dl', 'mcg/dl', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Total iron binding capacity', '', 'TIBC', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Total iron binding capacity', '', 'TIBC', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mcg/dl' ), 'TIBC(Huyết thanh)', 'TIBC', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1138', 1310, 'TIBC', '2500-7', 'ovn-1138', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'TIBC' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'TIBC' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'TIBC(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TIBC(Huyết thanh)' ), 'N', NULL, now(), 1860, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TIBC(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 240.00, 450.00);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'uUI/ML', 'uUI/ML', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Thyrotropin', '', 'TSH', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Thyrotropin', '', 'TSH', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'uUI/ML' ), 'TSH(Huyết thanh)', 'TSH', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1139', 1320, 'TSH', '3016-3', 'ovn-1139', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'TSH' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'TSH' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'TSH(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TSH(Huyết thanh)' ), 'N', NULL, now(), 1870, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TSH(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.35, 4.94);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'pg/ml', 'pg/ml', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Triiodothyronine.free', '', 'Free T3', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Triiodothyronine.free', '', 'Free T3', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'pg/ml' ), 'Free T3(Huyết thanh)', 'Free T3', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1140', 1330, 'Free T3', '3051-0', 'ovn-1140', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Free T3' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Free T3' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Free T3(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Free T3(Huyết thanh)' ), 'N', NULL, now(), 1880, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Free T3(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 1.50, 4.20);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Triiodothyronine.free', '', 'Free T3', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Triiodothyronine.free', '', 'Free T3', now() );
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'ng/dl', 'ng/dl', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Thyroxine.free', '', 'Free T4', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Thyroxine.free', '', 'Free T4', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/dl' ), 'Free T4(Huyết thanh)', 'Free T4', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1142', 1340, 'Free T4', '3024-7', 'ovn-1142', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Free T4' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Free T4' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Free T4(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Free T4(Huyết thanh)' ), 'N', NULL, now(), 1890, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Free T4(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.70, 1.48);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Alpha-1-Fetoprotein', '', 'AFP', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Alpha-1-Fetoprotein', '', 'AFP', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/ml' ), 'AFP(Huyết thanh)', 'AFP', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1143', 1350, 'AFP', '1834-1', 'ovn-1143', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'AFP' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'AFP' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'AFP(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'AFP(Huyết thanh)' ), 'N', NULL, now(), 1900, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'AFP(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 1.09, 8.04);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cortisol - morning', '', 'Cortisol - sáng', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cortisol - morning', '', 'Cortisol - sáng', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ug/dl' ), 'Cortisol - sáng(Huyết thanh)', 'Cortisol - sáng', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1144', 1360, 'Cortisol - sáng', '9813-7', 'ovn-1144', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cortisol - sáng' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cortisol - sáng' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Cortisol - sáng(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cortisol - sáng(Huyết thanh)' ), 'N', NULL, now(), 1910, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cortisol - sáng(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 3.70, 19.40);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cortisol - pm', '', 'Cortisol - chiều', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cortisol - pm', '', 'Cortisol - chiều', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ug/dl' ), 'Cortisol - chiều(Huyết thanh)', 'Cortisol - chiều', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1145', 1370, 'Cortisol - chiều', '9812-9', 'ovn-1145', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cortisol - chiều' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cortisol - chiều' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Cortisol - chiều(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cortisol - chiều(Huyết thanh)' ), 'N', NULL, now(), 1920, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cortisol - chiều(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 2.90, 17.30);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mIU/ml', 'mIU/ml', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Beta-HCG', '', 'Beta HCG', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Beta-HCG', '', 'Beta HCG', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mIU/ml' ), 'Beta HCG(Huyết thanh)', 'Beta HCG', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1146', 1380, 'Beta HCG', '21198-7', 'ovn-1146', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Beta HCG' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Beta HCG' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Beta HCG(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Beta HCG(Huyết thanh)' ), 'N', NULL, now(), 1930, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Beta HCG(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 5.00, 25.00);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'ug/ml', 'ug/ml', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Parathyroid hormone', '', 'PTH', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Parathyroid hormone', '', 'PTH', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ug/ml' ), 'PTH(Huyết thanh)', 'PTH', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1147', 1390, 'PTH', '2730-0', 'ovn-1147', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'PTH' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'PTH' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'PTH(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PTH(Huyết thanh)' ), 'N', NULL, now(), 1940, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PTH(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 1.00, 60.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lutropin', '', 'LH', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lutropin', '', 'LH', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'LH(Huyết thanh)', 'LH', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1148', 1400, 'LH', '10501-5', 'ovn-1148', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'LH' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'LH' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'LH(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LH(Huyết thanh)' ), 'N', NULL, now(), 1950, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LH(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Follitropin', '', 'FSH', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Follitropin', '', 'FSH', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'FSH(Huyết thanh)', 'FSH', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1149', 1410, 'FSH', '15067-2', 'ovn-1149', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'FSH' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'FSH' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'FSH(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'FSH(Huyết thanh)' ), 'N', NULL, now(), 1960, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'FSH(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Estradiol', '', 'Estradiol', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Estradiol', '', 'Estradiol', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Estradiol(Huyết thanh)', 'Estradiol', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1150', 1420, 'Estradiol', '2243-4', 'ovn-1150', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Estradiol' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Estradiol' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Estradiol(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Estradiol(Huyết thanh)' ), 'N', NULL, now(), 1970, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Estradiol(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cyclosporine', '', 'Cyclosporin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cyclosporine', '', 'Cyclosporin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/ml' ), 'Cyclosporin(Huyết thanh)', 'Cyclosporin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1151', 1430, 'Cyclosporin', '3521-2', 'ovn-1151', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cyclosporin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cyclosporin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Cyclosporin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cyclosporin(Huyết thanh)' ), 'N', NULL, now(), 1980, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cyclosporin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Tacrolimus', '', 'Tacrolimus', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Tacrolimus', '', 'Tacrolimus', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/ml' ), 'Tacrolimus(Huyết thanh)', 'Tacrolimus', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1152', 1440, 'Tacrolimus', '32721-3', 'ovn-1152', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Tacrolimus' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Tacrolimus' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Tacrolimus(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tacrolimus(Huyết thanh)' ), 'N', NULL, now(), 1990, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tacrolimus(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Triiodothyronine', '', 'T3', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Triiodothyronine', '', 'T3', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/ml' ), 'T3(Huyết thanh)', 'T3', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1153', 1450, 'T3', '3053-6', 'ovn-1153', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'T3' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'T3' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'T3(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'T3(Huyết thanh)' ), 'N', NULL, now(), 2000, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'T3(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.50, 1.60);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Triiodothyronine', '', 'T3', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Triiodothyronine', '', 'T3', now() );
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'IU/ml', 'IU/ml', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Thyroglobulin Ab', '', 'Anti -Tg', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Thyroglobulin Ab', '', 'Anti -Tg', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'IU/ml' ), 'Anti -Tg(Huyết thanh)', 'Anti -Tg', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1155', 1460, 'Anti -Tg', '8098-6', 'ovn-1155', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Anti -Tg' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Anti -Tg' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti -Tg(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti -Tg(Huyết thanh)' ), 'N', NULL, now(), 2010, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti -Tg(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 4.11);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Thyroglobulin Ab', '', 'Anti -Tg', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Thyroglobulin Ab', '', 'Anti -Tg', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Thyroid peroxidase Ab', '', 'Anti - TPO', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Thyroid peroxidase Ab', '', 'Anti - TPO', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'IU/ml' ), 'Anti - TPO(Huyết thanh)', 'Anti - TPO', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1157', 1470, 'Anti - TPO', '8099-4', 'ovn-1157', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Anti - TPO' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Anti - TPO' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti - TPO(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti - TPO(Huyết thanh)' ), 'N', NULL, now(), 2020, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti - TPO(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 5.61);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Thyroid peroxidase Ab', '', 'Anti - TPO', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Thyroid peroxidase Ab', '', 'Anti - TPO', now() );
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'ng/mL', 'ng/mL', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Carcinoembryonic Ag', '', 'CEA', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Carcinoembryonic Ag', '', 'CEA', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/mL' ), 'CEA(Huyết thanh)', 'CEA', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1159', 1480, 'CEA', '2039-6', 'ovn-1159', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CEA' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CEA' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'CEA(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CEA(Huyết thanh)' ), 'N', NULL, now(), 2030, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CEA(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 5.00);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'U/mL', 'U/mL', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cancer Ag 125', '', 'CA125', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cancer Ag 125', '', 'CA125', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'U/mL' ), 'CA125(Huyết thanh)', 'CA125', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1160', 1490, 'CA125', '10334-1', 'ovn-1160', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CA125' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CA125' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'CA125(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CA125(Huyết thanh)' ), 'N', NULL, now(), 2040, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CA125(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 35.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cancer Ag 15-3', '', 'CA 15-3', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cancer Ag 15-3', '', 'CA 15-3', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'U/mL' ), 'CA 15-3(Huyết thanh)', 'CA 15-3', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1161', 1500, 'CA 15-3', '6875-9', 'ovn-1161', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CA 15-3' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CA 15-3' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'CA 15-3(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CA 15-3(Huyết thanh)' ), 'N', NULL, now(), 2050, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CA 15-3(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 28.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Beta-2-Microglobulin', '', 'B2 - Microglobulin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Beta-2-Microglobulin', '', 'B2 - Microglobulin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ug/l' ), 'B2 - Microglobulin(Huyết thanh)', 'B2 - Microglobulin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1162', 1510, 'B2 - Microglobulin', '1952-1', 'ovn-1162', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'B2 - Microglobulin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'B2 - Microglobulin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'B2 - Microglobulin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'B2 - Microglobulin(Huyết thanh)' ), 'N', NULL, now(), 2060, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'B2 - Microglobulin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 2000.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Prostate specific Ag', '', 'PSA', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Prostate specific Ag', '', 'PSA', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ug/l' ), 'PSA(Huyết thanh)', 'PSA', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1163', 1520, 'PSA', '2857-1', 'ovn-1163', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'PSA' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'PSA' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'PSA(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PSA(Huyết thanh)' ), 'N', NULL, now(), 2070, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PSA(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 4.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cancer Ag 19-9', '', 'CA 19-9', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cancer Ag 19-9', '', 'CA 19-9', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'U/mL' ), 'CA 19-9(Huyết thanh)', 'CA 19-9', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1164', 1530, 'CA 19-9', '24108-3', 'ovn-1164', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CA 19-9' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CA 19-9' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'CA 19-9(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CA 19-9(Huyết thanh)' ), 'N', NULL, now(), 2080, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CA 19-9(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 37.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Squamous cell carcinoma Ag', '', 'SCC', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Squamous cell carcinoma Ag', '', 'SCC', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ug/l' ), 'SCC(Huyết thanh)', 'SCC', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1165', 1540, 'SCC', '9679-2', 'ovn-1165', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'SCC' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'SCC' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'SCC(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'SCC(Huyết thanh)' ), 'N', NULL, now(), 2090, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'SCC(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 1.50);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Thyroglobulin', '', 'Tg', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Thyroglobulin', '', 'Tg', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/ml' ), 'Tg(Huyết thanh)', 'Tg', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1166', 1550, 'Tg', '3013-0', 'ovn-1166', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Tg' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Tg' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Tg(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tg(Huyết thanh)' ), 'N', NULL, now(), 2100, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tg(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 1.40, 78.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Estrogen', '', 'Estrogen', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Estrogen', '', 'Estrogen', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Estrogen(Huyết thanh)', 'Estrogen', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1167', 1560, 'Estrogen', '2254-1', 'ovn-1167', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Estrogen' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Estrogen' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Estrogen(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Estrogen(Huyết thanh)' ), 'N', NULL, now(), 2110, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Estrogen(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Progesterone', '', 'Progesterone', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Progesterone', '', 'Progesterone', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Progesterone(Huyết thanh)', 'Progesterone', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1168', 1570, 'Progesterone', '2839-9', 'ovn-1168', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Progesterone' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Progesterone' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Progesterone(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Progesterone(Huyết thanh)' ), 'N', NULL, now(), 2120, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Progesterone(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cytokeratin 19 fragment 21-1', '', 'CYFRA21.1', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cytokeratin 19 fragment 21-1', '', 'CYFRA21.1', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/mL' ), 'CYFRA21.1(Huyết thanh)', 'CYFRA21.1', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1169', 1580, 'CYFRA21.1', '25390-6', 'ovn-1169', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CYFRA21.1' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CYFRA21.1' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'CYFRA21.1(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CYFRA21.1(Huyết thanh)' ), 'N', NULL, now(), 2130, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CYFRA21.1(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 3.30);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'pg/mL', 'pg/mL', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Parathyroid hormone.intact', '', 'iPTH', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Parathyroid hormone.intact', '', 'iPTH', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'pg/mL' ), 'iPTH(Huyết thanh)', 'iPTH', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1170', 1590, 'iPTH', '2731-8', 'ovn-1170', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'iPTH' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'iPTH' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'iPTH(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'iPTH(Huyết thanh)' ), 'N', NULL, now(), 2140, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'iPTH(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 15.00, 68.30);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Enolase.neuron specific', '', 'NSE', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Enolase.neuron specific', '', 'NSE', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/mL' ), 'NSE(Huyết thanh)', 'NSE', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1171', 1600, 'NSE', '15060-7', 'ovn-1171', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'NSE' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'NSE' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'NSE(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'NSE(Huyết thanh)' ), 'N', NULL, now(), 2150, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'NSE(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 17.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Human epididymis protein 4', '', 'HE.4', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Human epididymis protein 4', '', 'HE.4', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'HE.4(Huyết thanh)', 'HE.4', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1172', 1610, 'HE.4', '55180-4', 'ovn-1172', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HE.4' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HE.4' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'HE.4(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HE.4(Huyết thanh)' ), 'N', NULL, now(), 2160, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HE.4(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Pro-gastrin-releasing peptide', '', 'Pro_GRP', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Pro-gastrin-releasing peptide', '', 'Pro_GRP', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'pg/mL' ), 'Pro_GRP(Huyết thanh)', 'Pro_GRP', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1173', 1620, 'Pro_GRP', '2329-1', 'ovn-1173', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Pro_GRP' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Pro_GRP' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Pro_GRP(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Pro_GRP(Huyết thanh)' ), 'N', NULL, now(), 2170, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Pro_GRP(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 65.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Prolactin', '', 'Prolactin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Prolactin', '', 'Prolactin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'ng/mL' ), 'Prolactin(Huyết thanh)', 'Prolactin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1174', 1630, 'Prolactin', '2842-3', 'ovn-1174', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Prolactin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Prolactin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Prolactin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Prolactin(Huyết thanh)' ), 'N', NULL, now(), 2180, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Prolactin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 5.18, 26.53);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Prostate specific Ag.free', '', 'Free PSA', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Prostate specific Ag.free', '', 'Free PSA', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Free PSA(Huyết thanh)', 'Free PSA', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1175', 1640, 'Free PSA', '10886-0', 'ovn-1175', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Free PSA' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Free PSA' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Free PSA(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Free PSA(Huyết thanh)' ), 'N', NULL, now(), 2190, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Free PSA(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Testosterone', '', 'Testosterone', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Testosterone', '', 'Testosterone', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Testosterone(Huyết thanh)', 'Testosterone', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1176', 1650, 'Testosterone', '2986-8', 'ovn-1176', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Testosterone' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Testosterone' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Testosterone(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Testosterone(Huyết thanh)' ), 'N', NULL, now(), 2200, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Testosterone(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Helicobacter pylori Ab.IgM', '', 'H.Pylori IgM', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Helicobacter pylori Ab.IgM', '', 'H.Pylori IgM', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'H.Pylori IgM(Huyết thanh)', 'H.Pylori IgM', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1177', 1660, 'H.Pylori IgM', '7903-8', 'ovn-1177', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'H.Pylori IgM' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'H.Pylori IgM' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'H.Pylori IgM(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'H.Pylori IgM(Huyết thanh)' ), 'N', NULL, now(), 2210, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'H.Pylori IgM(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Helicobacter pylori Ab.IgG', '', 'H.Pylori IgG', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Helicobacter pylori Ab.IgG', '', 'H.Pylori IgG', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'H.Pylori IgG(Huyết thanh)', 'H.Pylori IgG', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1178', 1670, 'H.Pylori IgG', '7902-0', 'ovn-1178', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'H.Pylori IgG' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'H.Pylori IgG' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'H.Pylori IgG(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'H.Pylori IgG(Huyết thanh)' ), 'N', NULL, now(), 2220, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'H.Pylori IgG(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Calcitonin', '', 'Calcitonin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Calcitonin', '', 'Calcitonin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Calcitonin(Huyết thanh)', 'Calcitonin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1179', 1680, 'Calcitonin', '1992-7', 'ovn-1179', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Calcitonin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Calcitonin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Calcitonin(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Calcitonin(Huyết thanh)' ), 'N', NULL, now(), 2230, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Calcitonin(Huyết thanh)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'S/CO', 'S/CO', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus surface Ag', '', 'HBsAg', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus surface Ag', '', 'HBsAg', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'S/CO' ), 'HBsAg(Huyết thanh)', 'HBsAg', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1180', 1690, 'HBsAg', '5195-3', 'ovn-1180', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HBsAg' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HBsAg' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'HBsAg(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HBsAg(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2240, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HBsAg(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2250, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus surface Ag, rapid test', '', 'HBsAg', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus surface Ag, rapid test', '', 'HBsAg', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'HBsAg(Máu)', 'HBsAg', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1181', 1700, 'HBsAg', NULL, 'ovn-1181', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HBsAg' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HBsAg' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HBsAg(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HBsAg(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2270, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HBsAg(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2280, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus surface Ag, ELISA', '', 'Elisa HBsAg', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus surface Ag, ELISA', '', 'Elisa HBsAg', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Elisa HBsAg(Huyết thanh)', 'Elisa HBsAg', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1182', 1710, 'Elisa HBsAg', '5196-1', 'ovn-1182', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Elisa HBsAg' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Elisa HBsAg' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa HBsAg(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa HBsAg(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2300, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa HBsAg(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2310, NULL, false);
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Nghi ngờ', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus surface Ag, ELISA', '', 'Elisa HBsAg', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus surface Ag, ELISA', '', 'Elisa HBsAg', now() );
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Dưới ngưỡng phát hiện', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis C virus real-time PCR (advanced)', '', 'HCV (chi tiết) Real-Time PCR', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis C virus real-time PCR (advanced)', '', 'HCV (chi tiết) Real-Time PCR', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'HCV (chi tiết) Real-Time PCR(Máu)', 'HCV (chi tiết) Real-Time PCR', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1184', 1720, 'HCV (chi tiết) Real-Time PCR', '5010-4', 'ovn-1184', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HCV (chi tiết) Real-Time PCR' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HCV (chi tiết) Real-Time PCR' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HCV (chi tiết) Real-Time PCR(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HCV (chi tiết) Real-Time PCR(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2330, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HCV (chi tiết) Real-Time PCR(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2340, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HCV (chi tiết) Real-Time PCR(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dưới ngưỡng phát hiện' ), now(), 2350, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis C virus, rapid test', '', 'Test HCV', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis C virus, rapid test', '', 'Test HCV', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test HCV(Máu)', 'Test HCV', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1185', 1730, 'Test HCV', '72376-7', 'ovn-1185', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test HCV' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test HCV' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HCV(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HCV(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2370, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HCV(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2380, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis C virus Ab', '', 'Anti HCV', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis C virus Ab', '', 'Anti HCV', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'S/CO' ), 'Anti HCV(Huyết thanh)', 'Anti HCV', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1186', 1740, 'Anti HCV', '16128-1', 'ovn-1186', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Anti HCV' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Anti HCV' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HCV(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HCV(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2400, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HCV(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2410, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus core Ab.IgM', '', 'Anti - HBc IgM', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus core Ab.IgM', '', 'Anti - HBc IgM', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Anti - HBc IgM(Máu)', 'Anti - HBc IgM', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1187', 1750, 'Anti - HBc IgM', '31204-1', 'ovn-1187', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Anti - HBc IgM' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Anti - HBc IgM' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti - HBc IgM(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti - HBc IgM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2430, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti - HBc IgM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2440, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus core Ab.total', '', 'Anti - HBc Total', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus core Ab.total', '', 'Anti - HBc Total', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Anti - HBc Total(Máu)', 'Anti - HBc Total', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1188', 1760, 'Anti - HBc Total', '16933-4', 'ovn-1188', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Anti - HBc Total' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Anti - HBc Total' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti - HBc Total(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti - HBc Total(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2460, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti - HBc Total(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2470, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis A virus Ab.IgM', '', 'Anti HAV - IgM', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis A virus Ab.IgM', '', 'Anti HAV - IgM', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Anti HAV - IgM(Máu)', 'Anti HAV - IgM', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1189', 1770, 'Anti HAV - IgM', '22314-9', 'ovn-1189', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Anti HAV - IgM' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Anti HAV - IgM' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HAV - IgM(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HAV - IgM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2490, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HAV - IgM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2500, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis A virus Ab.IgG', '', 'Anti HAV - IgG', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis A virus Ab.IgG', '', 'Anti HAV - IgG', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Anti HAV - IgG(Máu)', 'Anti HAV - IgG', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1190', 1780, 'Anti HAV - IgG', '32018-4', 'ovn-1190', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Anti HAV - IgG' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Anti HAV - IgG' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HAV - IgG(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HAV - IgG(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2520, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HAV - IgG(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2530, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis A virus Ab.total', '', 'Anti HAV - Total', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis A virus Ab.total', '', 'Anti HAV - Total', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Anti HAV - Total(Máu)', 'Anti HAV - Total', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1191', 1790, 'Anti HAV - Total', '20575-7', 'ovn-1191', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Anti HAV - Total' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Anti HAV - Total' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HAV - Total(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HAV - Total(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2550, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HAV - Total(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2560, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis C virus Ab, ELISA', '', 'Elisa anti HCV', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis C virus Ab, ELISA', '', 'Elisa anti HCV', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Elisa anti HCV(Huyết thanh)', 'Elisa anti HCV', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1192', 1800, 'Elisa anti HCV', '13955-0', 'ovn-1192', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Elisa anti HCV' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Elisa anti HCV' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa anti HCV(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa anti HCV(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2580, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa anti HCV(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2590, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa anti HCV(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nghi ngờ' ), now(), 2600, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus e Ag, rapid test', '', 'Test HBeAg', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus e Ag, rapid test', '', 'Test HBeAg', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test HBeAg(Máu)', 'Test HBeAg', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1193', 1810, 'Test HBeAg', '13954-3', 'ovn-1193', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test HBeAg' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test HBeAg' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HBeAg(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HBeAg(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2620, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HBeAg(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2630, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus surface Ab, ELISA', '', 'Elisa anti HBs', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus surface Ab, ELISA', '', 'Elisa anti HBs', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'S/CO' ), 'Elisa anti HBs(Huyết thanh)', 'Elisa anti HBs', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1194', 1820, 'Elisa anti HBs', '10900-9', 'ovn-1194', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Elisa anti HBs' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Elisa anti HBs' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa anti HBs(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa anti HBs(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2650, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa anti HBs(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2660, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa anti HBs(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nghi ngờ' ), now(), 2670, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus core Ab, rapid test', '', 'Test anti HBc', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus core Ab, rapid test', '', 'Test anti HBc', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test anti HBc(Máu)', 'Test anti HBc', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1195', 1830, 'Test anti HBc', NULL, 'ovn-1195', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test anti HBc' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test anti HBc' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test anti HBc(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test anti HBc(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2690, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test anti HBc(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2700, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus e Ab, rapid test', '', 'Test anti HBe', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus e Ab, rapid test', '', 'Test anti HBe', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test anti HBe(Máu)', 'Test anti HBe', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1196', 1840, 'Test anti HBe', NULL, 'ovn-1196', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test anti HBe' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test anti HBe' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test anti HBe(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test anti HBe(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2720, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test anti HBe(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2730, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis C virus Ab, rapid test', '', 'Test anti HCV', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis C virus Ab, rapid test', '', 'Test anti HCV', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test anti HCV(Máu)', 'Test anti HCV', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1197', 1850, 'Test anti HCV', '72376-7', 'ovn-1197', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test anti HCV' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test anti HCV' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test anti HCV(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test anti HCV(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2750, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test anti HCV(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2760, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus surface Ab, rapid test', '', 'Test HBsAb', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus surface Ab, rapid test', '', 'Test HBsAb', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test HBsAb(Máu)', 'Test HBsAb', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1198', 1860, 'Test HBsAb', NULL, 'ovn-1198', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test HBsAb' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test HBsAb' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HBsAb(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HBsAb(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2780, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HBsAb(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2790, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus surface Ag, rapid test', '', 'Test HBsAg', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus surface Ag, rapid test', '', 'Test HBsAg', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test HBsAg(Máu)', 'Test HBsAg', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1199', 1870, 'Test HBsAg', NULL, 'ovn-1199', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test HBsAg' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test HBsAg' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HBsAg(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HBsAg(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2810, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test HBsAg(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2820, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus e Ab', '', 'Anti HBe', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus e Ab', '', 'Anti HBe', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Anti HBe(Máu)', 'Anti HBe', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1200', 1880, 'Anti HBe', '22320-6', 'ovn-1200', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Anti HBe' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Anti HBe' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HBe(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HBe(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2840, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HBe(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2850, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hepatitis B virus surface Ab', '', 'Anti HBs', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hepatitis B virus surface Ab', '', 'Anti HBs', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Anti HBs(Máu)', 'Anti HBs', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1201', 1890, 'Anti HBs', '22322-2', 'ovn-1201', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Anti HBs' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Anti HBs' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HBs(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HBs(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2870, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Anti HBs(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2880, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Dengue virus Ab.IgM, ELISA', '', 'Elisa Dengue IgM', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Dengue virus Ab.IgM, ELISA', '', 'Elisa Dengue IgM', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Elisa Dengue IgM(Huyết thanh)', 'Elisa Dengue IgM', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1202', 1900, 'Elisa Dengue IgM', '29663-2', 'ovn-1202', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Elisa Dengue IgM' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Elisa Dengue IgM' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa Dengue IgM(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa Dengue IgM(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2900, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa Dengue IgM(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2910, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa Dengue IgM(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nghi ngờ' ), now(), 2920, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Dengue virus Ab.IgG, ELISA', '', 'Elisa Dengue IgG', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Dengue virus Ab.IgG, ELISA', '', 'Elisa Dengue IgG', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Elisa Dengue IgG(Huyết thanh)', 'Elisa Dengue IgG', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1203', 1910, 'Elisa Dengue IgG', '29661-6', 'ovn-1203', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Elisa Dengue IgG' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Elisa Dengue IgG' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa Dengue IgG(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa Dengue IgG(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2940, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa Dengue IgG(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2950, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Elisa Dengue IgG(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nghi ngờ' ), now(), 2960, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Dengue virus Ab.IgM, rapid test', '', 'Test Dengue IgM', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Dengue virus Ab.IgM, rapid test', '', 'Test Dengue IgM', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test Dengue IgM(Máu)', 'Test Dengue IgM', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1204', 1920, 'Test Dengue IgM', NULL, 'ovn-1204', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test Dengue IgM' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test Dengue IgM' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test Dengue IgM(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test Dengue IgM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 2980, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test Dengue IgM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 2990, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Dengue virus Ab.IgG, rapid test', '', 'Test Dengue IgG', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Dengue virus Ab.IgG, rapid test', '', 'Test Dengue IgG', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test Dengue IgG(Máu)', 'Test Dengue IgG', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1205', 1930, 'Test Dengue IgG', NULL, 'ovn-1205', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test Dengue IgG' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test Dengue IgG' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test Dengue IgG(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test Dengue IgG(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 3010, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test Dengue IgG(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 3020, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Dengue virus NS1 Ag, rapid test', '', 'Test nhanh NS1Ag', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Dengue virus NS1 Ag, rapid test', '', 'Test nhanh NS1Ag', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test nhanh NS1Ag(Máu)', 'Test nhanh NS1Ag', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1206', 1940, 'Test nhanh NS1Ag', NULL, 'ovn-1206', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test nhanh NS1Ag' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test nhanh NS1Ag' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test nhanh NS1Ag(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test nhanh NS1Ag(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 3040, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test nhanh NS1Ag(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 3050, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'VDRL', '', 'VDRL', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'VDRL', '', 'VDRL', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'VDRL(Máu)', 'VDRL', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1207', 1950, 'VDRL', '5292-8', 'ovn-1207', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'VDRL' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'VDRL' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'VDRL(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'VDRL(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 3070, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'VDRL(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 3080, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'CD4 cells #', '', 'CD4#', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'CD4 cells #', '', 'CD4#', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'CD4#(Máu)', 'CD4#', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1208', 1960, 'CD4#', '24467-3', 'ovn-1208', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CD4#' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CD4#' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'CD4#(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CD4#(Máu)' ), 'N', NULL, now(), 3100, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CD4#(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'CD4 cells %', '', 'CD4%', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'CD4 cells %', '', 'CD4%', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'CD4%(Máu)', 'CD4%', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Immunology' ), 'ovn-1209', 1970, 'CD4%', '8123-2', 'ovn-1209', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'CD4%' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'CD4%' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'CD4%(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CD4%(Máu)' ), 'N', NULL, now(), 3110, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'CD4%(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.test_section ( id, name, description, is_external, lastupdated, display_key, sort_order, is_active ) VALUES
	( nextval( 'test_section_seq' ), 'HIV', 'HIV', 'N', now(), 'test.section.hiv', 30, 'Y');
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có phản ứng', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Không phản ứng', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Determine HIV 1/2 Rapid Test', '', 'Determine HIV 1/2 Rapid Test', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Determine HIV 1/2 Rapid Test', '', 'Determine HIV 1/2 Rapid Test', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Determine HIV 1/2 Rapid Test(Máu)', 'Determine HIV 1/2 Rapid Test', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'HIV' ), 'ovn-1210', 1980, 'Determine HIV 1/2 Rapid Test', '49580-4', 'ovn-1210', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Determine HIV 1/2 Rapid Test' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Determine HIV 1/2 Rapid Test' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Determine HIV 1/2 Rapid Test(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Determine HIV 1/2 Rapid Test(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có phản ứng' ), now(), 3120, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Determine HIV 1/2 Rapid Test(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không phản ứng' ), now(), 3130, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Determine HIV 1/2 Rapid Test', '', 'Determine HIV 1/2 Rapid Test', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Determine HIV 1/2 Rapid Test', '', 'Determine HIV 1/2 Rapid Test', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Determine HIV 1/2 Rapid Test(Huyết tương)', 'Determine HIV 1/2 Rapid Test', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'HIV' ), 'ovn-1211', 1990, 'Determine HIV 1/2 Rapid Test', '49580-4', 'ovn-1211', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Determine HIV 1/2 Rapid Test' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Determine HIV 1/2 Rapid Test' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết tương' ), ( SELECT id FROM clinlims.test WHERE description = 'Determine HIV 1/2 Rapid Test(Huyết tương)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Determine HIV 1/2 Rapid Test(Huyết tương)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có phản ứng' ), now(), 3150, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Determine HIV 1/2 Rapid Test(Huyết tương)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không phản ứng' ), now(), 3160, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Determine HIV 1/2 Rapid Test', '', 'Determine HIV 1/2 Rapid Test', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Determine HIV 1/2 Rapid Test', '', 'Determine HIV 1/2 Rapid Test', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Determine HIV 1/2 Rapid Test(Huyết thanh)', 'Determine HIV 1/2 Rapid Test', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'HIV' ), 'ovn-1212', 2000, 'Determine HIV 1/2 Rapid Test', '49580-4', 'ovn-1212', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Determine HIV 1/2 Rapid Test' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Determine HIV 1/2 Rapid Test' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'Determine HIV 1/2 Rapid Test(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Determine HIV 1/2 Rapid Test(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có phản ứng' ), now(), 3180, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Determine HIV 1/2 Rapid Test(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không phản ứng' ), now(), 3190, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'HIV 1+2 Ab, ELISA (Murex)', '', 'ELISA Murex HIV 1/2', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'HIV 1+2 Ab, ELISA (Murex)', '', 'ELISA Murex HIV 1/2', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'ELISA Murex HIV 1/2(Huyết thanh)', 'ELISA Murex HIV 1/2', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'HIV' ), 'ovn-1213', 2010, 'ELISA Murex HIV 1/2', '31201-7', 'ovn-1213', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'ELISA Murex HIV 1/2' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'ELISA Murex HIV 1/2' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Huyết thanh' ), ( SELECT id FROM clinlims.test WHERE description = 'ELISA Murex HIV 1/2(Huyết thanh)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'ELISA Murex HIV 1/2(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 3210, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'ELISA Murex HIV 1/2(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 3220, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'ELISA Murex HIV 1/2(Huyết thanh)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nghi ngờ' ), now(), 3230, NULL, false);
INSERT INTO clinlims.test_section ( id, name, description, is_external, lastupdated, display_key, sort_order, is_active ) VALUES
	( nextval( 'test_section_seq' ), 'Hematology', 'Hematology', 'N', now(), 'test.section.hematology', 40, 'Y');
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hematocrit', '', 'Hematocrit', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hematocrit', '', 'Hematocrit', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Hematocrit(Máu)', 'Hematocrit', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1219', 2020, 'Hematocrit', '20570-8', 'ovn-1219', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Hematocrit' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Hematocrit' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Hematocrit(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hematocrit(Máu)' ), 'N', NULL, now(), 3250, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hematocrit(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mm', 'mm', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Erythrocyte sedimentation, 1 hour', '', 'Máu lắng giờ 1', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Erythrocyte sedimentation, 1 hour', '', 'Máu lắng giờ 1', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mm' ), 'Máu lắng giờ 1(Máu)', 'Máu lắng giờ 1', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1220', 2030, 'Máu lắng giờ 1', '4537-7', 'ovn-1220', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Máu lắng giờ 1' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Máu lắng giờ 1' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu lắng giờ 1(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu lắng giờ 1(Máu)' ), 'N', NULL, now(), 3260, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu lắng giờ 1(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 10.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Erythrocyte sedimentation, 2 hour', '', 'Máu lắng giờ 2', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Erythrocyte sedimentation, 2 hour', '', 'Máu lắng giờ 2', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mm' ), 'Máu lắng giờ 2(Máu)', 'Máu lắng giờ 2', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1221', 2040, 'Máu lắng giờ 2', '18184-2', 'ovn-1221', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Máu lắng giờ 2' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Máu lắng giờ 2' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu lắng giờ 2(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu lắng giờ 2(Máu)' ), 'N', NULL, now(), 3270, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Máu lắng giờ 2(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 20.00);
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'phút', 'phút', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bleeding time', '', 'TS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bleeding time', '', 'TS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'phút' ), 'TS(Máu)', 'TS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1222', 2050, 'TS', '11067-6', 'ovn-1222', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'TS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'TS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'TS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TS(Máu)' ), 'N', NULL, now(), 3280, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 3.00);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Clotting time', '', 'TC', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Clotting time', '', 'TC', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'phút' ), 'TC(Máu)', 'TC', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1223', 2060, 'TC', '52789-5', 'ovn-1223', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'TC' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'TC' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'TC(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TC(Máu)' ), 'N', NULL, now(), 3290, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TC(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 9.00);
INSERT INTO clinlims.panel ( id, name, description, lastupdated, display_key, sort_order ) VALUES
	( nextval( 'panel_seq' ), 'Blood bank', 'Blood bank', now(), 'panel.name.blood.bank', 30);
INSERT INTO clinlims.sampletype_panel ( id, sample_type_id, panel_id ) VALUES
	( nextval( 'sample_type_panel_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood bank' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'A', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'B', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'AB', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'O', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Blood group ABO', '', 'Nhóm máu ABO', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Blood group ABO', '', 'Nhóm máu ABO', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Nhóm máu ABO(Máu)', 'Nhóm máu ABO', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1225', 2070, 'Nhóm máu ABO', '883-9', 'ovn-1225', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Nhóm máu ABO' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Nhóm máu ABO' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhóm máu ABO(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhóm máu ABO(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'A' ), now(), 3300, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhóm máu ABO(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'B' ), now(), 3310, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhóm máu ABO(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'AB' ), now(), 3320, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhóm máu ABO(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'O' ), now(), 3330, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood bank' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Nhóm máu ABO(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Rh', '', 'Rh', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Rh', '', 'Rh', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Rh(Máu)', 'Rh', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1226', 2080, 'Rh', '10331-7', 'ovn-1226', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Rh' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Rh' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Rh(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rh(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 3350, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rh(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 3360, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood bank' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Rh(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Red blood cell phenotype', '', 'Hồng cầu phenotype', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Red blood cell phenotype', '', 'Hồng cầu phenotype', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Hồng cầu phenotype(Máu)', 'Hồng cầu phenotype', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1228', 2090, 'Hồng cầu phenotype', NULL, 'ovn-1228', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Hồng cầu phenotype' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Hồng cầu phenotype' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Hồng cầu phenotype(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hồng cầu phenotype(Máu)' ), 'R', NULL, now(), 3380, 0, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Reticulocytes', '', 'Hồng cầu lưới', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Reticulocytes', '', 'Hồng cầu lưới', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Hồng cầu lưới(Máu)', 'Hồng cầu lưới', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1229', 2100, 'Hồng cầu lưới', '4679-7', 'ovn-1229', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Hồng cầu lưới' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Hồng cầu lưới' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Hồng cầu lưới(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hồng cầu lưới(Máu)' ), 'N', NULL, now(), 3390, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hồng cầu lưới(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lupus erythematosus cells', '', 'LE cells', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lupus erythematosus cells', '', 'LE cells', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'LE cells(Máu)', 'LE cells', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1230', 2110, 'LE cells', '13507-9', 'ovn-1230', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'LE cells' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'LE cells' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'LE cells(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LE cells(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 3400, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'LE cells(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 3410, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Coombs test, direct', '', 'Test de Combs (Trực tiếp)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Coombs test, direct', '', 'Test de Combs (Trực tiếp)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test de Combs (Trực tiếp)(Máu)', 'Test de Combs (Trực tiếp)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1231', 2120, 'Test de Combs (Trực tiếp)', '51006-5', 'ovn-1231', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test de Combs (Trực tiếp)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test de Combs (Trực tiếp)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test de Combs (Trực tiếp)(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test de Combs (Trực tiếp)(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 3430, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test de Combs (Trực tiếp)(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 3440, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Coombs test, indirect', '', 'Test de Combs (Gián tiếp)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Coombs test, indirect', '', 'Test de Combs (Gián tiếp)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Test de Combs (Gián tiếp)(Máu)', 'Test de Combs (Gián tiếp)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1232', 2130, 'Test de Combs (Gián tiếp)', '50959-6', 'ovn-1232', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Test de Combs (Gián tiếp)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Test de Combs (Gián tiếp)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Test de Combs (Gián tiếp)(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test de Combs (Gián tiếp)(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 3460, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Test de Combs (Gián tiếp)(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 3470, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Abnormal antibody screening', '', 'Sàng lọc kháng thể bất thường', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Abnormal antibody screening', '', 'Sàng lọc kháng thể bất thường', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Sàng lọc kháng thể bất thường(Máu)', 'Sàng lọc kháng thể bất thường', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1233', 2140, 'Sàng lọc kháng thể bất thường', '890-4', 'ovn-1233', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Sàng lọc kháng thể bất thường' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Sàng lọc kháng thể bất thường' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Sàng lọc kháng thể bất thường(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sàng lọc kháng thể bất thường(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 3490, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sàng lọc kháng thể bất thường(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 3500, NULL, false);
INSERT INTO clinlims.panel ( id, name, description, lastupdated, display_key, sort_order ) VALUES
	( nextval( 'panel_seq' ), 'Blood coagulation', 'Blood coagulation', now(), 'panel.name.blood.coagulation', 40);
INSERT INTO clinlims.sampletype_panel ( id, sample_type_id, panel_id ) VALUES
	( nextval( 'sample_type_panel_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Prothrombin time, seconds', '', 'PTs', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Prothrombin time, seconds', '', 'PTs', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'PTs(Máu)', 'PTs', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1235', 2150, 'PTs', '5902-2', 'ovn-1235', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'PTs' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'PTs' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'PTs(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PTs(Máu)' ), 'N', NULL, now(), 3520, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PTs(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'PTs(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Prothrombin time, seconds (control)', '', 'PTs chứng', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Prothrombin time, seconds (control)', '', 'PTs chứng', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'PTs chứng(Máu)', 'PTs chứng', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1236', 2160, 'PTs chứng', '5901-4', 'ovn-1236', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'PTs chứng' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'PTs chứng' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'PTs chứng(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PTs chứng(Máu)' ), 'N', NULL, now(), 3530, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PTs chứng(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'PTs chứng(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Prothrombin time, percent', '', 'PT%', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Prothrombin time, percent', '', 'PT%', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'PT%(Máu)', 'PT%', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1237', 2170, 'PT%', '5894-1', 'ovn-1237', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'PT%' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'PT%' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'PT%(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PT%(Máu)' ), 'N', NULL, now(), 3540, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PT%(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 70.00, 140.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'PT%(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'INR coagulation assay', '', 'INR', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'INR coagulation assay', '', 'INR', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'INR(Máu)', 'INR', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1238', 2180, 'INR', '6301-6', 'ovn-1238', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'INR' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'INR' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'INR(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'INR(Máu)' ), 'N', NULL, now(), 3550, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'INR(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.91, 1.11);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'INR(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Activated partial thromboplastin time', '', 'aPTT', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Activated partial thromboplastin time', '', 'aPTT', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'aPTT(Máu)', 'aPTT', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1239', 2190, 'aPTT', '14979-9', 'ovn-1239', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'aPTT' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'aPTT' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'aPTT(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'aPTT(Máu)' ), 'N', NULL, now(), 3560, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'aPTT(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'aPTT(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Activated partial thromboplastin time (Control)', '', 'aPTT chứng', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Activated partial thromboplastin time (Control)', '', 'aPTT chứng', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'aPTT chứng(Máu)', 'aPTT chứng', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1240', 2200, 'aPTT chứng', '13488-2', 'ovn-1240', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'aPTT chứng' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'aPTT chứng' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'aPTT chứng(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'aPTT chứng(Máu)' ), 'N', NULL, now(), 3570, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'aPTT chứng(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'aPTT chứng(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Fibrinogen', '', 'Fibrinogen', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Fibrinogen', '', 'Fibrinogen', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/l' ), 'Fibrinogen(Máu)', 'Fibrinogen', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1241', 2210, 'Fibrinogen', '3255-7', 'ovn-1241', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Fibrinogen' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Fibrinogen' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Fibrinogen(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Fibrinogen(Máu)' ), 'N', NULL, now(), 3580, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Fibrinogen(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 2.00, 4.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Fibrinogen(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Factor VIII', '', 'Yếu tố VIII', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Factor VIII', '', 'Yếu tố VIII', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Yếu tố VIII(Máu)', 'Yếu tố VIII', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1242', 2220, 'Yếu tố VIII', '3209-4', 'ovn-1242', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Yếu tố VIII' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Yếu tố VIII' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Yếu tố VIII(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Yếu tố VIII(Máu)' ), 'N', NULL, now(), 3590, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Yếu tố VIII(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 60.00, 150.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Yếu tố VIII(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Factor IX', '', 'Yếu tố IX', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Factor IX', '', 'Yếu tố IX', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Yếu tố IX(Máu)', 'Yếu tố IX', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1243', 2230, 'Yếu tố IX', '3187-2', 'ovn-1243', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Yếu tố IX' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Yếu tố IX' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Yếu tố IX(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Yếu tố IX(Máu)' ), 'N', NULL, now(), 3600, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Yếu tố IX(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 60.00, 150.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Yếu tố IX(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'µg/ml', 'µg/ml', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Fibrin D-dimer', '', 'D-Dimer', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Fibrin D-dimer', '', 'D-Dimer', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'µg/ml' ), 'D-Dimer(Máu)', 'D-Dimer', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1244', 2240, 'D-Dimer', '48065-7', 'ovn-1244', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'D-Dimer' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'D-Dimer' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'D-Dimer(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'D-Dimer(Máu)' ), 'N', NULL, now(), 3610, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'D-Dimer(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood coagulation' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'D-Dimer(Máu)' ));
INSERT INTO clinlims.panel ( id, name, description, lastupdated, display_key, sort_order ) VALUES
	( nextval( 'panel_seq' ), 'CBC', 'CBC', now(), 'panel.name.cbc', 50);
INSERT INTO clinlims.sampletype_panel ( id, sample_type_id, panel_id ) VALUES
	( nextval( 'sample_type_panel_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), '10^3/mm^3', '10^3/mm^3', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'White blood cells', '', 'WBC', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'White blood cells', '', 'WBC', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '10^3/mm^3' ), 'WBC(Máu)', 'WBC', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1246', 2250, 'WBC', '6690-2', 'ovn-1246', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'WBC' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'WBC' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'WBC(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'WBC(Máu)' ), 'N', NULL, now(), 3620, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'WBC(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 3.50, 10.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'WBC(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Neutrolphils %', '', '%NEU', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Neutrolphils %', '', '%NEU', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), '%NEU(Máu)', '%NEU', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1247', 2260, '%NEU', '770-8', 'ovn-1247', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '%NEU' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '%NEU' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '%NEU(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%NEU(Máu)' ), 'N', NULL, now(), 3630, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%NEU(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 55.00, 80.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '%NEU(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Neutrophils #', '', '#NEU', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Neutrophils #', '', '#NEU', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, '#NEU(Máu)', '#NEU', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1248', 2270, '#NEU', '751-8', 'ovn-1248', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '#NEU' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '#NEU' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '#NEU(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#NEU(Máu)' ), 'N', NULL, now(), 3640, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#NEU(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 2.80, 7.50);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '#NEU(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lymphocytes %', '', '%LYM', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lymphocytes %', '', '%LYM', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), '%LYM(Máu)', '%LYM', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1249', 2280, '%LYM', '736-9', 'ovn-1249', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '%LYM' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '%LYM' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '%LYM(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%LYM(Máu)' ), 'N', NULL, now(), 3650, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%LYM(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 17.00, 48.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '%LYM(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lymphocytes #', '', '#LYM', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lymphocytes #', '', '#LYM', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, '#LYM(Máu)', '#LYM', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1250', 2290, '#LYM', '731-0', 'ovn-1250', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '#LYM' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '#LYM' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '#LYM(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#LYM(Máu)' ), 'N', NULL, now(), 3660, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#LYM(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 1.20, 3.20);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '#LYM(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Monocytes %', '', '%MONO', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Monocytes %', '', '%MONO', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), '%MONO(Máu)', '%MONO', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1251', 2300, '%MONO', '5905-5', 'ovn-1251', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '%MONO' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '%MONO' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '%MONO(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%MONO(Máu)' ), 'N', NULL, now(), 3670, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%MONO(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 10.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '%MONO(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Monocytes #', '', '#MONO', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Monocytes #', '', '#MONO', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, '#MONO(Máu)', '#MONO', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1252', 2310, '#MONO', '742-7', 'ovn-1252', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '#MONO' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '#MONO' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '#MONO(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#MONO(Máu)' ), 'N', NULL, now(), 3680, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#MONO(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.10, 0.30);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '#MONO(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Eosinophils %', '', '%EOS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Eosinophils %', '', '%EOS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), '%EOS(Máu)', '%EOS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1253', 2320, '%EOS', '713-8', 'ovn-1253', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '%EOS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '%EOS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '%EOS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%EOS(Máu)' ), 'N', NULL, now(), 3690, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%EOS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 7.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '%EOS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Eosinophils #', '', '#EOS', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Eosinophils #', '', '#EOS', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, '#EOS(Máu)', '#EOS', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1254', 2330, '#EOS', '711-2', 'ovn-1254', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '#EOS' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '#EOS' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '#EOS(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#EOS(Máu)' ), 'N', NULL, now(), 3700, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#EOS(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.10, 0.40);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '#EOS(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Basophils %', '', '%BASO', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Basophils %', '', '%BASO', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), '%BASO(Máu)', '%BASO', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1255', 2340, '%BASO', '706-2', 'ovn-1255', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '%BASO' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '%BASO' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '%BASO(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%BASO(Máu)' ), 'N', NULL, now(), 3710, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%BASO(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 0.20);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '%BASO(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Basophils #', '', '#BASO', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Basophils #', '', '#BASO', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, '#BASO(Máu)', '#BASO', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1256', 2350, '#BASO', '704-7', 'ovn-1256', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '#BASO' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '#BASO' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '#BASO(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#BASO(Máu)' ), 'N', NULL, now(), 3720, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#BASO(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '#BASO(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Large unstained cells %', '', '%LUC', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Large unstained cells %', '', '%LUC', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), '%LUC(Máu)', '%LUC', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1257', 2360, '%LUC', '17788-1', 'ovn-1257', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '%LUC' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '%LUC' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '%LUC(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%LUC(Máu)' ), 'N', NULL, now(), 3730, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '%LUC(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 0.40);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '%LUC(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'K/uL', 'K/uL', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Large unstained cells #', '', '#LUC', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Large unstained cells #', '', '#LUC', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'K/uL' ), '#LUC(Máu)', '#LUC', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1258', 2370, '#LUC', '17789-9', 'ovn-1258', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = '#LUC' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = '#LUC' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = '#LUC(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#LUC(Máu)' ), 'N', NULL, now(), 3740, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = '#LUC(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 0.00, 4.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = '#LUC(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), '10^6/mm^3', '10^6/mm^3', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Red blood cells', '', 'RBC', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Red blood cells', '', 'RBC', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '10^6/mm^3' ), 'RBC(Máu)', 'RBC', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1259', 2380, 'RBC', '789-8', 'ovn-1259', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'RBC' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'RBC' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'RBC(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'RBC(Máu)' ), 'N', NULL, now(), 3750, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'RBC(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 3.40, 5.80);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'RBC(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'g/dL', 'g/dL', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoblobin', '', 'HGB', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoblobin', '', 'HGB', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/dL' ), 'HGB(Máu)', 'HGB', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1260', 2390, 'HGB', '20509-6', 'ovn-1260', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HGB' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HGB' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HGB(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HGB(Máu)' ), 'N', NULL, now(), 3760, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HGB(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 11.00, 16.50);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'HGB(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hematocrit', '', 'HCT', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hematocrit', '', 'HCT', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'HCT(Máu)', 'HCT', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1261', 2400, 'HCT', '4544-3', 'ovn-1261', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HCT' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HCT' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HCT(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HCT(Máu)' ), 'N', NULL, now(), 3770, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HCT(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 33.00, 50.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'HCT(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'um^3', 'um^3', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Mean corpuscular volume', '', 'MCV', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Mean corpuscular volume', '', 'MCV', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'um^3' ), 'MCV(Máu)', 'MCV', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1262', 2410, 'MCV', '787-2', 'ovn-1262', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'MCV' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'MCV' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'MCV(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'MCV(Máu)' ), 'N', NULL, now(), 3780, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'MCV(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 80.00, 97.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'MCV(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'pg', 'pg', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Mean corpuscular hemoglobin', '', 'MCH', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Mean corpuscular hemoglobin', '', 'MCH', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'pg' ), 'MCH(Máu)', 'MCH', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1263', 2420, 'MCH', '785-6', 'ovn-1263', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'MCH' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'MCH' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'MCH(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'MCH(Máu)' ), 'N', NULL, now(), 3790, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'MCH(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 26.50, 33.50);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'MCH(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Mean corpuscular hemoglobin concentration', '', 'MCHC', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Mean corpuscular hemoglobin concentration', '', 'MCHC', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/dl' ), 'MCHC(Máu)', 'MCHC', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1264', 2430, 'MCHC', '786-4', 'ovn-1264', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'MCHC' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'MCHC' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'MCHC(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'MCHC(Máu)' ), 'N', NULL, now(), 3800, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'MCHC(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 3.00, 35.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'MCHC(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Hemoglobin distribution width', '', 'HDW', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Hemoglobin distribution width', '', 'HDW', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'g/dL' ), 'HDW(Máu)', 'HDW', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1265', 2440, 'HDW', '46423-0', 'ovn-1265', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HDW' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HDW' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'HDW(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HDW(Máu)' ), 'N', NULL, now(), 3810, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HDW(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 2.20, 3.20);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'HDW(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Red cell distribution width', '', 'RDW', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Red cell distribution width', '', 'RDW', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'RDW(Máu)', 'RDW', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1266', 2450, 'RDW', '788-0', 'ovn-1266', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'RDW' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'RDW' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'RDW(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'RDW(Máu)' ), 'N', NULL, now(), 3820, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'RDW(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 10.00, 15.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'RDW(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Platelets', '', 'PLT', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Platelets', '', 'PLT', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '10^3/mm^3' ), 'PLT(Máu)', 'PLT', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1267', 2460, 'PLT', '777-3', 'ovn-1267', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'PLT' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'PLT' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'PLT(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PLT(Máu)' ), 'N', NULL, now(), 3830, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PLT(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 150.00, 450.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'PLT(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Mean platelet volume', '', 'MPV', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Mean platelet volume', '', 'MPV', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'um^3' ), 'MPV(Máu)', 'MPV', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1268', 2470, 'MPV', '32623-1', 'ovn-1268', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'MPV' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'MPV' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'MPV(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'MPV(Máu)' ), 'N', NULL, now(), 3840, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'MPV(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 6.50, 11.00);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'MPV(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'fL', 'fL', now());
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Red cell distribution width (SD)', '', 'RDW-SD', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Red cell distribution width (SD)', '', 'RDW-SD', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'fL' ), 'RDW-SD(Máu)', 'RDW-SD', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1269', 2480, 'RDW-SD', '21000-5', 'ovn-1269', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'RDW-SD' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'RDW-SD' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'RDW-SD(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'RDW-SD(Máu)' ), 'N', NULL, now(), 3850, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'RDW-SD(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 35.10, 46.30);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'RDW-SD(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Red cell distribution width (CV)', '', 'RDW-CV', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Red cell distribution width (CV)', '', 'RDW-CV', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'RDW-CV(Máu)', 'RDW-CV', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1270', 2490, 'RDW-CV', '788-0', 'ovn-1270', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'RDW-CV' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'RDW-CV' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'RDW-CV(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'RDW-CV(Máu)' ), 'N', NULL, now(), 3860, 2, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated, low_normal, high_normal ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'RDW-CV(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now(), 11.60, 14.40);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'RDW-CV(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Platelet large cell ratio', '', 'P-LCR', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Platelet large cell ratio', '', 'P-LCR', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'P-LCR(Máu)', 'P-LCR', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1271', 2500, 'P-LCR', '48386-7', 'ovn-1271', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'P-LCR' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'P-LCR' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'P-LCR(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'P-LCR(Máu)' ), 'N', NULL, now(), 3870, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'P-LCR(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'P-LCR(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Plateletcrit', '', 'PCT', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Plateletcrit', '', 'PCT', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'PCT(Máu)', 'PCT', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1272', 2510, 'PCT', '51637-7', 'ovn-1272', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'PCT' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'PCT' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'PCT(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PCT(Máu)' ), 'N', NULL, now(), 3880, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'PCT(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'CBC' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'PCT(Máu)' ));
INSERT INTO clinlims.unit_of_measure ( id, name, description, lastupdated ) VALUES
	( nextval( 'unit_of_measure_seq' ), 'mm3', 'mm3', now());
INSERT INTO clinlims.panel ( id, name, description, lastupdated, display_key, sort_order ) VALUES
	( nextval( 'panel_seq' ), 'Blood Smear', 'Blood Smear', now(), 'panel.name.blood.smear', 60);
INSERT INTO clinlims.sampletype_panel ( id, sample_type_id, panel_id ) VALUES
	( nextval( 'sample_type_panel_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Neutrolphils %', '', 'Neutrolphils', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Neutrolphils %', '', 'Neutrolphils', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Neutrolphils(Máu)', 'Neutrolphils', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1275', 2520, 'Neutrolphils', '23761-0', 'ovn-1275', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Neutrolphils' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Neutrolphils' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Neutrolphils(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Neutrolphils(Máu)' ), 'N', NULL, now(), 3890, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Neutrolphils(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Neutrolphils(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Eosinophils %', '', 'Eosinophils', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Eosinophils %', '', 'Eosinophils', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Eosinophils(Máu)', 'Eosinophils', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1276', 2530, 'Eosinophils', '714-6', 'ovn-1276', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Eosinophils' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Eosinophils' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Eosinophils(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Eosinophils(Máu)' ), 'N', NULL, now(), 3900, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Eosinophils(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Eosinophils(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Basophils %', '', 'Basophils', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Basophils %', '', 'Basophils', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Basophils(Máu)', 'Basophils', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1277', 2540, 'Basophils', '707-0', 'ovn-1277', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Basophils' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Basophils' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Basophils(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Basophils(Máu)' ), 'N', NULL, now(), 3910, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Basophils(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Basophils(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Lymphocytes %', '', 'Lymphocytes', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Lymphocytes %', '', 'Lymphocytes', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Lymphocytes(Máu)', 'Lymphocytes', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1278', 2550, 'Lymphocytes', '737-7', 'ovn-1278', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Lymphocytes' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Lymphocytes' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Lymphocytes(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lymphocytes(Máu)' ), 'N', NULL, now(), 3920, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Lymphocytes(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Lymphocytes(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Monocytes %', '', 'Monocytes', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Monocytes %', '', 'Monocytes', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = '%' ), 'Monocytes(Máu)', 'Monocytes', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1279', 2560, 'Monocytes', '744-3', 'ovn-1279', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Monocytes' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Monocytes' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Monocytes(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Monocytes(Máu)' ), 'N', NULL, now(), 3930, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Monocytes(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Monocytes(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Platelets #', '', 'Platelets', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Platelets #', '', 'Platelets', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), ( SELECT id FROM clinlims.unit_of_measure WHERE name = 'mm3' ), 'Platelets(Máu)', 'Platelets', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1280', 2570, 'Platelets', '778-1', 'ovn-1280', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Platelets' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Platelets' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Platelets(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Platelets(Máu)' ), 'N', NULL, now(), 3940, 0, false);
INSERT INTO clinlims.result_limits ( id, test_id, test_result_type_id, gender, lastupdated ) VALUES
	( nextval( 'result_limits_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Platelets(Máu)' ), ( SELECT id FROM clinlims.type_of_test_result WHERE test_result_type = 'N' ), '', now());
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Platelets(Máu)' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Bình sắc', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Nhược sắc', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Bạt màu không đều', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'RBC Color', '', 'Sắc tố hồng cầu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'RBC Color', '', 'Sắc tố hồng cầu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Sắc tố hồng cầu(Máu)', 'Sắc tố hồng cầu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1281', 2580, 'Sắc tố hồng cầu', NULL, 'ovn-1281', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Sắc tố hồng cầu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Sắc tố hồng cầu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắc tố hồng cầu(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắc tố hồng cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Bình sắc' ), now(), 3950, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắc tố hồng cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhược sắc' ), now(), 3960, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sắc tố hồng cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Bạt màu không đều' ), now(), 3970, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Sắc tố hồng cầu(Máu)' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Bình thường', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '(+)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '(++)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '(+++)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'RBC Anisocytosis', '', 'Kích thước', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'RBC Anisocytosis', '', 'Kích thước', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Kích thước(Máu)', 'Kích thước', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1282', 2590, 'Kích thước', '702-1', 'ovn-1282', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Kích thước' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Kích thước' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Kích thước(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Kích thước(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Bình thường' ), now(), 3990, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Kích thước(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '(+)' ), now(), 4000, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Kích thước(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '(++)' ), now(), 4010, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Kích thước(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '(+++)' ), now(), 4020, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Kích thước(Máu)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'RBC Poikilocytosis', '', 'Hình dạng', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'RBC Poikilocytosis', '', 'Hình dạng', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Hình dạng(Máu)', 'Hình dạng', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1283', 2600, 'Hình dạng', '779-9', 'ovn-1283', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Hình dạng' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Hình dạng' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Hình dạng(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hình dạng(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Bình thường' ), now(), 4040, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hình dạng(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '(+)' ), now(), 4050, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hình dạng(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '(++)' ), now(), 4060, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hình dạng(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '(+++)' ), now(), 4070, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Hình dạng(Máu)' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Nhiều', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Ít', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Rất ít', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Hơi ít', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Platelets', '', 'Tiểu cầu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Platelets', '', 'Tiểu cầu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Tiểu cầu(Máu)', 'Tiểu cầu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Hematology' ), 'ovn-1285', 2610, 'Tiểu cầu', '9317-9', 'ovn-1285', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Tiểu cầu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Tiểu cầu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Tiểu cầu(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tiểu cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhiều' ), now(), 4090, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tiểu cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Bình thường' ), now(), 4100, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tiểu cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Ít' ), now(), 4110, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tiểu cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Rất ít' ), now(), 4120, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tiểu cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Hơi ít' ), now(), 4130, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Blood Smear' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Tiểu cầu(Máu)' ));
INSERT INTO clinlims.test_section ( id, name, description, is_external, lastupdated, display_key, sort_order, is_active ) VALUES
	( nextval( 'test_section_seq' ), 'Microbiology', 'Microbiology', 'N', now(), 'test.section.microbiology', 50, 'Y');
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Vi trùng không mọc', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Vi trùng thường trú', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Cấy nấm ÂM TÍNH', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Lấy Lại Mẫu Nước Tiểu', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Mẫu không tin cậy', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Không có vi trùng gây bệnh', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Ngoại nhiễm', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Achromobacter xylosoxidans', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Acinetobacter spp', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Aeromonas hydrophila', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Alcaligenes', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Aspergillus', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Bacillus cereus', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Bacillus spp', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Burkholderia cepacia', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Campylobacter fetus', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Campylobacter jejuni', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Campylobacter spp', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Candida albicans', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Candida spp', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Chromobacterium violaceum', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Chryseobacterium indologenes', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Citrobacter diversus', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Citrobacter freundii', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Corynebacterium diptheriae', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Edwarsiella tarda', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Enterobacter aerogenes', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Enterobacter agglomerans', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Enterobacter cancerogenes', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Enterobacter cloacea', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Enterobacteriace spp', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Enterococcus faecalis', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Enterococcus faecium', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Escherichia coli', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Escherichia coli inactive', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Flavobacter meningosepticum', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Haemophilus aphrophilus', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Haemophilus influenzae', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Haemophilus parainfluenzae', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Haemophilus spp', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Klebsiella oxytoca', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Klebsiella ozaenae', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Klebsiella pneumoniae', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Listeria monocytogenes', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Moraxella catarrhalis', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Morganella morganii', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Nấm sợi', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Neisseria gonorrhoeae', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Neisseria meningitidis', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Ochrobactrum anthropi', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Proteus milabilis', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Proteus rettgeri', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Proteus vulgaris', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Pseudomonas aeruginosa', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Pseudomonas putida', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Pseudomonas spp', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Salmonella choleraesuis', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Salmonella OMA', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Salmonella OMB', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Salmonella OMC', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Salmonella paratyphi A', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Salmonella paratyphi B', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Salmonella paratyphi C', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Salmonella spp', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Salmonella typhi', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Serratia ficaria', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Serratia marcescens', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Shigella flexneri', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Shigella sonnei', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Sphigomonas paucimobilis', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Staphylococci coagulase âm', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Staphylococcus aureus', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Staphylococcus epidermidis', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Staphylococcus saprophiticus', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Stenotrophomonas maltophilia', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococci a hemolytic', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococci spp', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococci ß hemolytic', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococci ß hemolytic group D', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococci ß hemolytic group F', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococci ß hemolytic group G', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococci viridans', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococcus agalactiae', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococcus mitis', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococcus pneumoniae', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Streptococcus pyogenes', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Tìm không thấy hình dạng song cầu Gram Âm', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Tìm thấy hình dạng song cầu Gram Âm (+)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Tìm thấy hình dạng song cầu Gram Âm (++)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Tìm thấy hình dạng song cầu Gram Âm (+++)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Tìm thấy hình dạng song cầu Gram Âm (++++)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Culture', '', 'Nuôi cấy', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Culture', '', 'Nuôi cấy', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Nuôi cấy(Máu)', 'Nuôi cấy', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1286', 2620, 'Nuôi cấy', '11475-1', 'ovn-1286', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Nuôi cấy' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Nuôi cấy' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 4150, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Vi trùng không mọc' ), now(), 4160, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Vi trùng thường trú' ), now(), 4170, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Cấy nấm ÂM TÍNH' ), now(), 4180, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Lấy Lại Mẫu Nước Tiểu' ), now(), 4190, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Mẫu không tin cậy' ), now(), 4200, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không có vi trùng gây bệnh' ), now(), 4210, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Ngoại nhiễm' ), now(), 4220, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Achromobacter xylosoxidans' ), now(), 4230, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Acinetobacter spp' ), now(), 4240, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Aeromonas hydrophila' ), now(), 4250, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Alcaligenes' ), now(), 4260, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Aspergillus' ), now(), 4270, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Bacillus cereus' ), now(), 4280, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Bacillus spp' ), now(), 4290, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Burkholderia cepacia' ), now(), 4300, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Campylobacter fetus' ), now(), 4310, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Campylobacter jejuni' ), now(), 4320, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Campylobacter spp' ), now(), 4330, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Candida albicans' ), now(), 4340, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Candida spp' ), now(), 4350, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Chromobacterium violaceum' ), now(), 4360, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Chryseobacterium indologenes' ), now(), 4370, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Citrobacter diversus' ), now(), 4380, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Citrobacter freundii' ), now(), 4390, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Corynebacterium diptheriae' ), now(), 4400, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Edwarsiella tarda' ), now(), 4410, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Enterobacter aerogenes' ), now(), 4420, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Enterobacter agglomerans' ), now(), 4430, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Enterobacter cancerogenes' ), now(), 4440, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Enterobacter cloacea' ), now(), 4450, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Enterobacteriace spp' ), now(), 4460, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Enterococcus faecalis' ), now(), 4470, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Enterococcus faecium' ), now(), 4480, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Escherichia coli' ), now(), 4490, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Escherichia coli inactive' ), now(), 4500, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Flavobacter meningosepticum' ), now(), 4510, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Haemophilus aphrophilus' ), now(), 4520, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Haemophilus influenzae' ), now(), 4530, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Haemophilus parainfluenzae' ), now(), 4540, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Haemophilus spp' ), now(), 4550, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Klebsiella oxytoca' ), now(), 4560, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Klebsiella ozaenae' ), now(), 4570, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Klebsiella pneumoniae' ), now(), 4580, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Listeria monocytogenes' ), now(), 4590, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Moraxella catarrhalis' ), now(), 4600, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Morganella morganii' ), now(), 4610, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nấm sợi' ), now(), 4620, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Neisseria gonorrhoeae' ), now(), 4630, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Neisseria meningitidis' ), now(), 4640, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Ochrobactrum anthropi' ), now(), 4650, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Proteus milabilis' ), now(), 4660, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Proteus rettgeri' ), now(), 4670, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Proteus vulgaris' ), now(), 4680, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Pseudomonas aeruginosa' ), now(), 4690, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Pseudomonas putida' ), now(), 4700, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Pseudomonas spp' ), now(), 4710, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Salmonella choleraesuis' ), now(), 4720, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Salmonella OMA' ), now(), 4730, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Salmonella OMB' ), now(), 4740, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Salmonella OMC' ), now(), 4750, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Salmonella paratyphi A' ), now(), 4760, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Salmonella paratyphi B' ), now(), 4770, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Salmonella paratyphi C' ), now(), 4780, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Salmonella spp' ), now(), 4790, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Salmonella typhi' ), now(), 4800, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Serratia ficaria' ), now(), 4810, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Serratia marcescens' ), now(), 4820, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Shigella flexneri' ), now(), 4830, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Shigella sonnei' ), now(), 4840, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Sphigomonas paucimobilis' ), now(), 4850, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Staphylococci coagulase âm' ), now(), 4860, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Staphylococcus aureus' ), now(), 4870, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Staphylococcus epidermidis' ), now(), 4880, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Staphylococcus saprophiticus' ), now(), 4890, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Stenotrophomonas maltophilia' ), now(), 4900, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococci a hemolytic' ), now(), 4910, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococci spp' ), now(), 4920, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococci ß hemolytic' ), now(), 4930, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococci ß hemolytic group D' ), now(), 4940, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococci ß hemolytic group F' ), now(), 4950, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococci ß hemolytic group G' ), now(), 4960, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococci viridans' ), now(), 4970, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococcus agalactiae' ), now(), 4980, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococcus mitis' ), now(), 4990, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococcus pneumoniae' ), now(), 5000, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Streptococcus pyogenes' ), now(), 5010, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Tìm không thấy hình dạng song cầu Gram Âm' ), now(), 5020, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Tìm thấy hình dạng song cầu Gram Âm (+)' ), now(), 5030, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Tìm thấy hình dạng song cầu Gram Âm (++)' ), now(), 5040, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Tìm thấy hình dạng song cầu Gram Âm (+++)' ), now(), 5050, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nuôi cấy(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Tìm thấy hình dạng song cầu Gram Âm (++++)' ), now(), 5060, NULL, false);
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '1/80', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '1/160', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Widal test', '', 'Widal', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Widal test', '', 'Widal', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Widal(Máu)', 'Widal', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1287', 2630, 'Widal', '46204-4', 'ovn-1287', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Widal' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Widal' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Widal(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Widal(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 5080, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Widal(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 5090, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Widal(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '1/80' ), now(), 5100, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Widal(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '1/160' ), now(), 5110, NULL, false);
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Nấm', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Trực khuẩn GRAM âm', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình ảnh phẩy khuẩn bắt màu gram âm', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Cầu khuẩn GRAM dương', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Cầu khuẩn GRAM âm', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Không thấy hình dạng vi trùng', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dạng song cầu Gram âm (+)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'có hình dạng song cầu gram dương (sl: +,++,..)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'có hình dạng baci gram âm (sl: +,++,..)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'có hình dạng chuỗi cầu gram dương (sl: +,++,..)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'có hình dạng baci gram dương (sl: +,++,..)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'có hình dạng cocci gram dương (sl: +,++,..)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'baci gram âm bào tử trung tâm', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'baci gram âm bào tử gần cuối', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'baci gram âm bào tử ở giữa', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'baci gram dương bào tử trung tâm', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'baci gram dương bào tử gần cuối', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'baci gram dương bào tử ở giữa', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '10 - 25 bạch cầu', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '> 25 bạch cầu', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '10 - 25 tế bào biểu mô', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '> 25 tế bào biểu mô', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '< 10 bạch cầu', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '< 10 tế bào biểu mô', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'tế bào trụ', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'tế bào trụ +', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'tế bào trụ ++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dạng song cầu Gram âm (++)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Gram stain', '', 'Nhuộm GRAM', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Gram stain', '', 'Nhuộm GRAM', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Nhuộm GRAM(Máu)', 'Nhuộm GRAM', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1288', 2640, 'Nhuộm GRAM', '664-3', 'ovn-1288', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Nhuộm GRAM' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Nhuộm GRAM' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 5130, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nấm' ), now(), 5140, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trực khuẩn GRAM âm' ), now(), 5150, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình ảnh phẩy khuẩn bắt màu gram âm' ), now(), 5160, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Cầu khuẩn GRAM dương' ), now(), 5170, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Cầu khuẩn GRAM âm' ), now(), 5180, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không thấy hình dạng vi trùng' ), now(), 5190, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dạng song cầu Gram âm (+)' ), now(), 5200, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'có hình dạng song cầu gram dương (sl: +,++,..)' ), now(), 5210, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'có hình dạng baci gram âm (sl: +,++,..)' ), now(), 5220, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'có hình dạng chuỗi cầu gram dương (sl: +,++,..)' ), now(), 5230, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'có hình dạng baci gram dương (sl: +,++,..)' ), now(), 5240, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'có hình dạng cocci gram dương (sl: +,++,..)' ), now(), 5250, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'baci gram âm bào tử trung tâm' ), now(), 5260, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'baci gram âm bào tử gần cuối' ), now(), 5270, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'baci gram âm bào tử ở giữa' ), now(), 5280, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'baci gram dương bào tử trung tâm' ), now(), 5290, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'baci gram dương bào tử gần cuối' ), now(), 5300, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'baci gram dương bào tử ở giữa' ), now(), 5310, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '10 - 25 bạch cầu' ), now(), 5320, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '> 25 bạch cầu' ), now(), 5330, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '10 - 25 tế bào biểu mô' ), now(), 5340, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '> 25 tế bào biểu mô' ), now(), 5350, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '< 10 bạch cầu' ), now(), 5360, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '< 10 tế bào biểu mô' ), now(), 5370, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'tế bào trụ' ), now(), 5380, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'tế bào trụ +' ), now(), 5390, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'tế bào trụ ++' ), now(), 5400, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm GRAM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dạng song cầu Gram âm (++)' ), now(), 5410, NULL, false);
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Dương tính (Trực khuẩn kháng cồn kháng toan)', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Không thấy hình dạng trực khuẩn kháng cồn, kháng acid', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dạng trực khuẩn kháng cồn, kháng acid +', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dạng trực khuẩn kháng cồn, kháng acid ++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dạng trực khuẩn kháng cồn, kháng acid +++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ziehl-Neelsen stain', '', 'Nhuộm Ziehl-Nelsen', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ziehl-Neelsen stain', '', 'Nhuộm Ziehl-Nelsen', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Nhuộm Ziehl-Nelsen(Máu)', 'Nhuộm Ziehl-Nelsen', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1289', 2650, 'Nhuộm Ziehl-Nelsen', '72357-7', 'ovn-1289', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Nhuộm Ziehl-Nelsen' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Nhuộm Ziehl-Nelsen' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm Ziehl-Nelsen(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm Ziehl-Nelsen(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 5430, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm Ziehl-Nelsen(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính (Trực khuẩn kháng cồn kháng toan)' ), now(), 5440, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm Ziehl-Nelsen(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không thấy hình dạng trực khuẩn kháng cồn, kháng acid' ), now(), 5450, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm Ziehl-Nelsen(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dạng trực khuẩn kháng cồn, kháng acid +' ), now(), 5460, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm Ziehl-Nelsen(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dạng trực khuẩn kháng cồn, kháng acid ++' ), now(), 5470, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm Ziehl-Nelsen(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dạng trực khuẩn kháng cồn, kháng acid +++' ), now(), 5480, NULL, false);
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Không thấy hình dạng Cryptococcus neoformans', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dạng Cryptococcus neoformans +', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dạng Cryptococcus neoformans ++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dạng Cryptococcus neoformans +++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'India ink stain', '', 'Nhuộm mực tàu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'India ink stain', '', 'Nhuộm mực tàu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Nhuộm mực tàu(Máu)', 'Nhuộm mực tàu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1290', 2660, 'Nhuộm mực tàu', '666-8', 'ovn-1290', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Nhuộm mực tàu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Nhuộm mực tàu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm mực tàu(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm mực tàu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 5500, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm mực tàu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nấm' ), now(), 5510, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm mực tàu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không thấy hình dạng Cryptococcus neoformans' ), now(), 5520, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm mực tàu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dạng Cryptococcus neoformans +' ), now(), 5530, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm mực tàu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dạng Cryptococcus neoformans ++' ), now(), 5540, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm mực tàu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dạng Cryptococcus neoformans +++' ), now(), 5550, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'VDRL rapid test', '', 'Giang mai', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'VDRL rapid test', '', 'Giang mai', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Giang mai(Máu)', 'Giang mai', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1291', 2670, 'Giang mai', '5292-8', 'ovn-1291', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Giang mai' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Giang mai' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Giang mai(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Giang mai(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 5570, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Giang mai(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 5580, NULL, false);
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Cryptosporidium +', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Cryptosporidium ++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Cryptosporidium +++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cryptosporidium stain', '', 'Nhuộm CRYPTOSPORIDIUM', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cryptosporidium stain', '', 'Nhuộm CRYPTOSPORIDIUM', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Nhuộm CRYPTOSPORIDIUM(Máu)', 'Nhuộm CRYPTOSPORIDIUM', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1292', 2680, 'Nhuộm CRYPTOSPORIDIUM', '41488-8', 'ovn-1292', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Nhuộm CRYPTOSPORIDIUM' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Nhuộm CRYPTOSPORIDIUM' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm CRYPTOSPORIDIUM(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm CRYPTOSPORIDIUM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Cryptosporidium +' ), now(), 5600, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm CRYPTOSPORIDIUM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Cryptosporidium ++' ), now(), 5610, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nhuộm CRYPTOSPORIDIUM(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Cryptosporidium +++' ), now(), 5620, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Helicobacter pylori Ag', '', 'HP/ Phân', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Helicobacter pylori Ag', '', 'HP/ Phân', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'HP/ Phân(Phân)', 'HP/ Phân', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1293', 2690, 'HP/ Phân', '31843-6', 'ovn-1293', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'HP/ Phân' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'HP/ Phân' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Phân' ), ( SELECT id FROM clinlims.test WHERE description = 'HP/ Phân(Phân)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HP/ Phân(Phân)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 5640, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'HP/ Phân(Phân)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Dương tính' ), now(), 5650, NULL, false);
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Không thấy hình dạng trực khuẩn bạch hầu', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dạng trực khuẩn bạch hầu +', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dạng trực khuẩn bạch hầu ++++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dang trực khuẩn bạch hầu ++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Có hình dang trực khuẩn bạch hầu +++', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Diphtheria', '', 'Bạch hầu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Diphtheria', '', 'Bạch hầu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Bạch hầu(Máu)', 'Bạch hầu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1294', 2700, 'Bạch hầu', NULL, 'ovn-1294', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Bạch hầu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Bạch hầu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Bạch hầu(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bạch hầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không thấy hình dạng trực khuẩn bạch hầu' ), now(), 5670, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bạch hầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dạng trực khuẩn bạch hầu +' ), now(), 5680, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bạch hầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dạng trực khuẩn bạch hầu ++++' ), now(), 5690, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bạch hầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dang trực khuẩn bạch hầu ++' ), now(), 5700, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bạch hầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Có hình dang trực khuẩn bạch hầu +++' ), now(), 5710, NULL, false);
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '< 10', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '10-25', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '>25', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.type_of_sample ( id, description, domain, lastupdated, local_abbrev, display_key, sort_order, is_active ) VALUES
	( nextval( 'type_of_sample_seq' ), 'Đàm', 'H', now(), 'Đàm', 'sample.type.sputum', 80, 'Y');
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Epithelial cells', '', 'TẾ BÀO BIỂU MÔ', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Epithelial cells', '', 'TẾ BÀO BIỂU MÔ', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'TẾ BÀO BIỂU MÔ(Đàm)', 'TẾ BÀO BIỂU MÔ', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1295', 2710, 'TẾ BÀO BIỂU MÔ', '14327-1', 'ovn-1295', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'TẾ BÀO BIỂU MÔ' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'TẾ BÀO BIỂU MÔ' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Đàm' ), ( SELECT id FROM clinlims.test WHERE description = 'TẾ BÀO BIỂU MÔ(Đàm)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TẾ BÀO BIỂU MÔ(Đàm)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '< 10' ), now(), 5730, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TẾ BÀO BIỂU MÔ(Đàm)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '10-25' ), now(), 5740, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'TẾ BÀO BIỂU MÔ(Đàm)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '>25' ), now(), 5750, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'White blood cells', '', 'Bạch cầu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'White blood cells', '', 'Bạch cầu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Bạch cầu(Máu)', 'Bạch cầu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1296', 2720, 'Bạch cầu', '20455-2', 'ovn-1296', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Bạch cầu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Bạch cầu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Bạch cầu(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bạch cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '< 10' ), now(), 5770, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bạch cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '10-25' ), now(), 5780, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Bạch cầu(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '>25' ), now(), 5790, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Fecal fat droplets', '', 'Hạt Mỡ', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Fecal fat droplets', '', 'Hạt Mỡ', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Hạt Mỡ(Phân)', 'Hạt Mỡ', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1297', 2730, 'Hạt Mỡ', '2270-7', 'ovn-1297', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Hạt Mỡ' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Hạt Mỡ' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Phân' ), ( SELECT id FROM clinlims.test WHERE description = 'Hạt Mỡ(Phân)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hạt Mỡ(Phân)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 5810, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hạt Mỡ(Phân)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 5820, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hạt Mỡ(Phân)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 5830, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Hạt Mỡ(Phân)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 5840, NULL, false);
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Muscle fibers', '', 'Sợi cơ', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Muscle fibers', '', 'Sợi cơ', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Sợi cơ(Máu)', 'Sợi cơ', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1298', 2740, 'Sợi cơ', '2605-4', 'ovn-1298', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Sợi cơ' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Sợi cơ' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Máu' ), ( SELECT id FROM clinlims.test WHERE description = 'Sợi cơ(Máu)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sợi cơ(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+' ), now(), 5860, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sợi cơ(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++' ), now(), 5870, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sợi cơ(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+++' ), now(), 5880, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Sợi cơ(Máu)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '++++' ), now(), 5890, NULL, false);
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'R1: H.influenzae', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'R2: S.pneumoniae', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'R3: N.meningitidis A', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'R4: N.meningitidis B', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'R5: N.meningitidis C', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bacterial meningitis, latex agglutination', '', 'Latex', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bacterial meningitis, latex agglutination', '', 'Latex', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Latex(CSF)', 'Latex', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1302', 2750, 'Latex', NULL, 'ovn-1302', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Latex' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Latex' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'CSF' ), ( SELECT id FROM clinlims.test WHERE description = 'Latex(CSF)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Latex(CSF)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Âm tính' ), now(), 5910, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Latex(CSF)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'R1: H.influenzae' ), now(), 5920, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Latex(CSF)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'R2: S.pneumoniae' ), now(), 5930, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Latex(CSF)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'R3: N.meningitidis A' ), now(), 5940, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Latex(CSF)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'R4: N.meningitidis B' ), now(), 5950, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Latex(CSF)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'R5: N.meningitidis C' ), now(), 5960, NULL, false);
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Candida boidinii', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Candida colliculosa', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Candida dubliniensis', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Candida famata', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Candida glabrata', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Aspergillus fumigatus', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Aspergillus flavus', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'NẤM MEN', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'NẤM VÀ SỢI TƠ NẤM', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '+2 Mẫu tin cậy', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '+1 Mẫu tin cậy vừa', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '-1', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '-2', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '+3 Mẫu tin cậy', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', '0', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Bartlett score', '', 'Barllet', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Bartlett score', '', 'Barllet', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Barllet(Đàm)', 'Barllet', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1305', 2760, 'Barllet', NULL, 'ovn-1305', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Barllet' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Barllet' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Đàm' ), ( SELECT id FROM clinlims.test WHERE description = 'Barllet(Đàm)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Barllet(Đàm)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+2 Mẫu tin cậy' ), now(), 5980, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Barllet(Đàm)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+1 Mẫu tin cậy vừa' ), now(), 5990, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Barllet(Đàm)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '-1' ), now(), 6000, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Barllet(Đàm)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '-2' ), now(), 6010, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Barllet(Đàm)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '+3 Mẫu tin cậy' ), now(), 6020, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Barllet(Đàm)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = '0' ), now(), 6030, NULL, false);
INSERT INTO clinlims.type_of_sample ( id, description, domain, lastupdated, local_abbrev, display_key, sort_order, is_active ) VALUES
	( nextval( 'type_of_sample_seq' ), 'Isolate', 'H', now(), 'Isolate', 'sample.type.isolate', 90, 'Y');
INSERT INTO clinlims.panel ( id, name, description, lastupdated, display_key, sort_order ) VALUES
	( nextval( 'panel_seq' ), 'Antibiotics map', 'Antibiotics map', now(), 'panel.name.antibiotics.map', 70);
INSERT INTO clinlims.sampletype_panel ( id, sample_type_id, panel_id ) VALUES
	( nextval( 'sample_type_panel_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Nhạy', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Kháng', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Trung gian', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.dictionary ( id, is_active, dict_entry, lastupdated, dictionary_category_id ) VALUES
	( nextval( 'dictionary_seq' ), 'Y', 'Không nhạy', now(), ( SELECT id FROM clinlims.dictionary_category WHERE description = 'Haiti Lab' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Vancomycin (Enterococcus)', '', 'Vancom (Enterococci)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Vancomycin (Enterococcus)', '', 'Vancom (Enterococci)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Vancom (Enterococci)(Isolate)', 'Vancom (Enterococci)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1310', 2770, 'Vancom (Enterococci)', '19000-9', 'ovn-1310', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Vancom (Enterococci)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Vancom (Enterococci)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Vancom (Enterococci)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Vancom (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6050, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Vancom (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6060, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Vancom (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6070, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Vancom (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6080, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Vancom (Enterococci)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Rifampicin (Gonococcus)', '', 'Rifampin (Gono)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Rifampicin (Gonococcus)', '', 'Rifampin (Gono)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Rifampin (Gono)(Isolate)', 'Rifampin (Gono)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1311', 2780, 'Rifampin (Gono)', '18974-6', 'ovn-1311', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Rifampin (Gono)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Rifampin (Gono)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Gono)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Gono)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6100, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Gono)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6110, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Gono)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6120, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Gono)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6130, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Gono)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Rifampicin (Meningococcus)', '', 'Rifampin (Menin)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Rifampicin (Meningococcus)', '', 'Rifampin (Menin)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Rifampin (Menin)(Isolate)', 'Rifampin (Menin)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1312', 2790, 'Rifampin (Menin)', '18974-6', 'ovn-1312', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Rifampin (Menin)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Rifampin (Menin)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Menin)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Menin)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6150, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Menin)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6160, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Menin)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6170, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Menin)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6180, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Rifampin (Menin)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ampicillin (Enterococcus)', '', 'Ampicilline (Enterococci)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ampicillin (Enterococcus)', '', 'Ampicilline (Enterococci)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ampicilline (Enterococci)(Isolate)', 'Ampicilline (Enterococci)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1313', 2800, 'Ampicilline (Enterococci)', '18864-9', 'ovn-1313', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ampicilline (Enterococci)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ampicilline (Enterococci)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampicilline (Enterococci)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampicilline (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6200, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampicilline (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6210, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampicilline (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6220, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampicilline (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6230, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ampicilline (Enterococci)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Rifampicin (Enterococcus)', '', 'Rifampicine (Enterococci)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Rifampicin (Enterococcus)', '', 'Rifampicine (Enterococci)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Rifampicine (Enterococci)(Isolate)', 'Rifampicine (Enterococci)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1314', 2810, 'Rifampicine (Enterococci)', '18974-6', 'ovn-1314', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Rifampicine (Enterococci)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Rifampicine (Enterococci)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine (Enterococci)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6250, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6260, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6270, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine (Enterococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6280, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine (Enterococci)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Penicillin', '', 'Penicillin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Penicillin', '', 'Penicillin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Penicillin(Isolate)', 'Penicillin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1315', 2820, 'Penicillin', '18964-7', 'ovn-1315', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Penicillin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Penicillin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Penicillin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Penicillin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6300, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Penicillin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6310, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Penicillin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6320, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Penicillin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6330, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Penicillin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Oxacillin', '', 'Oxacilin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Oxacillin', '', 'Oxacilin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Oxacilin(Isolate)', 'Oxacilin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1316', 2830, 'Oxacilin', '18961-3', 'ovn-1316', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Oxacilin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Oxacilin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Oxacilin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Oxacilin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6350, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Oxacilin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6360, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Oxacilin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6370, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Oxacilin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6380, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Oxacilin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ampicillin', '', 'Ampicillin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ampicillin', '', 'Ampicillin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ampicillin(Isolate)', 'Ampicillin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1317', 2840, 'Ampicillin', '18864-9', 'ovn-1317', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ampicillin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ampicillin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampicillin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampicillin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6400, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampicillin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6410, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampicillin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6420, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampicillin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6430, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ampicillin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Amoxicillin+Clavulanate', '', 'Amo/Clavu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Amoxicillin+Clavulanate', '', 'Amo/Clavu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Amo/Clavu(Isolate)', 'Amo/Clavu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1318', 2850, 'Amo/Clavu', '18862-3', 'ovn-1318', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Amo/Clavu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Amo/Clavu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Amo/Clavu(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amo/Clavu(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6450, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amo/Clavu(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6460, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amo/Clavu(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6470, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amo/Clavu(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6480, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Amo/Clavu(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Carbenicillin', '', 'Carbenicilline', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Carbenicillin', '', 'Carbenicilline', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Carbenicilline(Isolate)', 'Carbenicilline', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1319', 2860, 'Carbenicilline', '18873-0', 'ovn-1319', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Carbenicilline' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Carbenicilline' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6500, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6510, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6520, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6530, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Carbenicillin (P. aeruginosa)', '', 'Carbenicilline (P.aeruginosa)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Carbenicillin (P. aeruginosa)', '', 'Carbenicilline (P.aeruginosa)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Carbenicilline (P.aeruginosa)(Isolate)', 'Carbenicilline (P.aeruginosa)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1320', 2870, 'Carbenicilline (P.aeruginosa)', '18873-0', 'ovn-1320', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Carbenicilline (P.aeruginosa)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Carbenicilline (P.aeruginosa)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline (P.aeruginosa)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline (P.aeruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6550, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline (P.aeruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6560, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline (P.aeruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6570, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline (P.aeruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6580, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Carbenicilline (P.aeruginosa)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ampicillin+Sulbactam', '', 'Ampi(sulbactam)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ampicillin+Sulbactam', '', 'Ampi(sulbactam)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ampi(sulbactam)(Isolate)', 'Ampi(sulbactam)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1321', 2880, 'Ampi(sulbactam)', '18865-6', 'ovn-1321', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ampi(sulbactam)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ampi(sulbactam)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampi(sulbactam)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampi(sulbactam)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6600, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampi(sulbactam)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6610, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampi(sulbactam)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6620, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ampi(sulbactam)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6630, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ampi(sulbactam)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Piperacillin+Tazobactam', '', 'Piperacillin+Tazo', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Piperacillin+Tazobactam', '', 'Piperacillin+Tazo', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Piperacillin+Tazo(Isolate)', 'Piperacillin+Tazo', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1322', 2890, 'Piperacillin+Tazo', '18970-4', 'ovn-1322', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Piperacillin+Tazo' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Piperacillin+Tazo' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6650, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6660, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6670, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6680, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ticarcillin+Clavulanate', '', 'Ticarcilin/A.Clavu', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ticarcillin+Clavulanate', '', 'Ticarcilin/A.Clavu', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ticarcilin/A.Clavu(Isolate)', 'Ticarcilin/A.Clavu', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1323', 2900, 'Ticarcilin/A.Clavu', '18995-1', 'ovn-1323', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ticarcilin/A.Clavu' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ticarcilin/A.Clavu' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6700, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6710, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6720, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6730, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefoperazone+Sulbactam', '', 'Cefoperazone/sul', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefoperazone+Sulbactam', '', 'Cefoperazone/sul', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefoperazone/sul(Isolate)', 'Cefoperazone/sul', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1324', 2910, 'Cefoperazone/sul', '54166-4', 'ovn-1324', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefoperazone/sul' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefoperazone/sul' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone/sul(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone/sul(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6750, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone/sul(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6760, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone/sul(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6770, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone/sul(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6780, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone/sul(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cephalothin', '', 'Cefalothin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cephalothin', '', 'Cefalothin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefalothin(Isolate)', 'Cefalothin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1325', 2920, 'Cefalothin', '18900-1', 'ovn-1325', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefalothin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefalothin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefalothin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefalothin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6800, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefalothin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6810, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefalothin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6820, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefalothin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6830, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefalothin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Piperacillin+Tazobactam (P. aeruginosa)', '', 'Piperacillin+Tazo(P.aeuruginosa)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Piperacillin+Tazobactam (P. aeruginosa)', '', 'Piperacillin+Tazo(P.aeuruginosa)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Piperacillin+Tazo(P.aeuruginosa)(Isolate)', 'Piperacillin+Tazo(P.aeuruginosa)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1326', 2930, 'Piperacillin+Tazo(P.aeuruginosa)', '18970-4', 'ovn-1326', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Piperacillin+Tazo(P.aeuruginosa)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Piperacillin+Tazo(P.aeuruginosa)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(P.aeuruginosa)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(P.aeuruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6850, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(P.aeuruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6860, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(P.aeuruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6870, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(P.aeuruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6880, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Piperacillin+Tazo(P.aeuruginosa)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefazolin', '', 'Cefazoline', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefazolin', '', 'Cefazoline', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefazoline(Isolate)', 'Cefazoline', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1327', 2940, 'Cefazoline', '18878-9', 'ovn-1327', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefazoline' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefazoline' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefazoline(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefazoline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6900, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefazoline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6910, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefazoline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6920, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefazoline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6930, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefazoline(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefuroxime', '', 'Cefuroxime', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefuroxime', '', 'Cefuroxime', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefuroxime(Isolate)', 'Cefuroxime', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1328', 2950, 'Cefuroxime', '51724-3', 'ovn-1328', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefuroxime' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefuroxime' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 6950, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 6960, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 6970, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 6980, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ticarcillin+Clavulanate (P. aeruginosa)', '', 'Ticarcilin/A.Clavu(P.aeuruginosa)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ticarcillin+Clavulanate (P. aeruginosa)', '', 'Ticarcilin/A.Clavu(P.aeuruginosa)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ticarcilin/A.Clavu(P.aeuruginosa)(Isolate)', 'Ticarcilin/A.Clavu(P.aeuruginosa)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1329', 2960, 'Ticarcilin/A.Clavu(P.aeuruginosa)', '18995-1', 'ovn-1329', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ticarcilin/A.Clavu(P.aeuruginosa)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ticarcilin/A.Clavu(P.aeuruginosa)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(P.aeuruginosa)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(P.aeuruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7000, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(P.aeuruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7010, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(P.aeuruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7020, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(P.aeuruginosa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7030, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ticarcilin/A.Clavu(P.aeuruginosa)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefoperazone', '', 'Cefoperazone', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefoperazone', '', 'Cefoperazone', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefoperazone(Isolate)', 'Cefoperazone', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1330', 2970, 'Cefoperazone', '18884-7', 'ovn-1330', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefoperazone' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefoperazone' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7050, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7060, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7070, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7080, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefoperazone(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefotaxime', '', 'Cefotaxime', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefotaxime', '', 'Cefotaxime', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefotaxime(Isolate)', 'Cefotaxime', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1331', 2980, 'Cefotaxime', '18886-2', 'ovn-1331', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefotaxime' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefotaxime' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefotaxime(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefotaxime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7100, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefotaxime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7110, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefotaxime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7120, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefotaxime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7130, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefotaxime(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefuroxime sodium', '', 'Cefuroxime(sodium)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefuroxime sodium', '', 'Cefuroxime(sodium)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefuroxime(sodium)(Isolate)', 'Cefuroxime(sodium)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1332', 2990, 'Cefuroxime(sodium)', '18896-1', 'ovn-1332', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefuroxime(sodium)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefuroxime(sodium)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(sodium)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(sodium)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7150, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(sodium)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7160, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(sodium)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7170, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(sodium)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7180, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime(sodium)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ceftriaxone', '', 'Ceftriaxone', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ceftriaxone', '', 'Ceftriaxone', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ceftriaxone(Isolate)', 'Ceftriaxone', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1333', 3000, 'Ceftriaxone', '18895-3', 'ovn-1333', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ceftriaxone' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ceftriaxone' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ceftriaxone(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ceftriaxone(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7200, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ceftriaxone(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7210, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ceftriaxone(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7220, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ceftriaxone(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7230, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ceftriaxone(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ceftazidime', '', 'Ceftazidime', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ceftazidime', '', 'Ceftazidime', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ceftazidime(Isolate)', 'Ceftazidime', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1334', 3010, 'Ceftazidime', '18893-8', 'ovn-1334', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ceftazidime' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ceftazidime' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ceftazidime(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ceftazidime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7250, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ceftazidime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7260, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ceftazidime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7270, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ceftazidime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7280, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ceftazidime(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefepime', '', 'Cefepime', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefepime', '', 'Cefepime', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefepime(Isolate)', 'Cefepime', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1335', 3020, 'Cefepime', '18879-7', 'ovn-1335', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefepime' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefepime' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefepime(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefepime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7300, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefepime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7310, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefepime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7320, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefepime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7330, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefepime(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefoxitin', '', 'Cefoxitin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefoxitin', '', 'Cefoxitin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefoxitin(Isolate)', 'Cefoxitin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1336', 3030, 'Cefoxitin', '18888-8', 'ovn-1336', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefoxitin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefoxitin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoxitin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoxitin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7350, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoxitin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7360, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoxitin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7370, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefoxitin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7380, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefoxitin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefotetan', '', 'Cefotetan', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefotetan', '', 'Cefotetan', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefotetan(Isolate)', 'Cefotetan', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1337', 3040, 'Cefotetan', '18887-0', 'ovn-1337', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefotetan' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefotetan' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefotetan(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefotetan(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7400, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefotetan(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7410, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefotetan(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7420, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefotetan(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7430, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefotetan(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefaclor', '', 'Cefaclor', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefaclor', '', 'Cefaclor', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefaclor(Isolate)', 'Cefaclor', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1338', 3050, 'Cefaclor', '18874-8', 'ovn-1338', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefaclor' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefaclor' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefaclor(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefaclor(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7450, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefaclor(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7460, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefaclor(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7470, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefaclor(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7480, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefaclor(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefixime', '', 'Cefixime', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefixime', '', 'Cefixime', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefixime(Isolate)', 'Cefixime', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1339', 3060, 'Cefixime', '18880-5', 'ovn-1339', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefixime' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefixime' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefixime(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefixime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7500, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefixime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7510, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefixime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7520, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefixime(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7530, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefixime(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Aztreonam', '', 'Aztreonam', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Aztreonam', '', 'Aztreonam', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Aztreonam(Isolate)', 'Aztreonam', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1340', 3070, 'Aztreonam', '18868-0', 'ovn-1340', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Aztreonam' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Aztreonam' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Aztreonam(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Aztreonam(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7550, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Aztreonam(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7560, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Aztreonam(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7570, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Aztreonam(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7580, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Aztreonam(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Cefuroxime axetil', '', 'Cefuroxime axetil', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Cefuroxime axetil', '', 'Cefuroxime axetil', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Cefuroxime axetil(Isolate)', 'Cefuroxime axetil', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1341', 3080, 'Cefuroxime axetil', '35783-0', 'ovn-1341', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Cefuroxime axetil' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Cefuroxime axetil' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime axetil(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime axetil(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7600, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime axetil(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7610, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime axetil(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7620, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime axetil(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7630, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Cefuroxime axetil(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Imipenem', '', 'Imipenem', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Imipenem', '', 'Imipenem', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Imipenem(Isolate)', 'Imipenem', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1342', 3090, 'Imipenem', '18932-4', 'ovn-1342', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Imipenem' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Imipenem' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Imipenem(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Imipenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7650, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Imipenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7660, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Imipenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7670, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Imipenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7680, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Imipenem(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Meropenem', '', 'Meropenem', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Meropenem', '', 'Meropenem', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Meropenem(Isolate)', 'Meropenem', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1343', 3100, 'Meropenem', '18943-1', 'ovn-1343', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Meropenem' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Meropenem' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7700, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7710, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7720, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7730, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ertapenem', '', 'Ertapenem', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ertapenem', '', 'Ertapenem', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ertapenem(Isolate)', 'Ertapenem', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1344', 3110, 'Ertapenem', '35802-8', 'ovn-1344', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ertapenem' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ertapenem' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ertapenem(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ertapenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7750, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ertapenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7760, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ertapenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7770, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ertapenem(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7780, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ertapenem(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Gentamicin', '', 'Gentamicin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Gentamicin', '', 'Gentamicin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Gentamicin(Isolate)', 'Gentamicin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1345', 3120, 'Gentamicin', '18928-2', 'ovn-1345', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Gentamicin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Gentamicin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Gentamicin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gentamicin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7800, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gentamicin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7810, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gentamicin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7820, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gentamicin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7830, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Gentamicin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Meropenem (P. cepacia, P. maltophilia)', '', 'Meropenem(P.Cepa/P.malto)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Meropenem (P. cepacia, P. maltophilia)', '', 'Meropenem(P.Cepa/P.malto)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Meropenem(P.Cepa/P.malto)(Isolate)', 'Meropenem(P.Cepa/P.malto)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1346', 3130, 'Meropenem(P.Cepa/P.malto)', '18943-1', 'ovn-1346', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Meropenem(P.Cepa/P.malto)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Meropenem(P.Cepa/P.malto)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(P.Cepa/P.malto)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(P.Cepa/P.malto)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7850, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(P.Cepa/P.malto)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7860, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(P.Cepa/P.malto)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7870, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(P.Cepa/P.malto)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7880, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Meropenem(P.Cepa/P.malto)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Amikacin', '', 'Amikacin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Amikacin', '', 'Amikacin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Amikacin(Isolate)', 'Amikacin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1347', 3140, 'Amikacin', '18860-7', 'ovn-1347', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Amikacin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Amikacin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Amikacin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amikacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7900, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amikacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7910, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amikacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7920, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Amikacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7930, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Amikacin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Tobramycin', '', 'Tobramycin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Tobramycin', '', 'Tobramycin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Tobramycin(Isolate)', 'Tobramycin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1348', 3150, 'Tobramycin', '18996-9', 'ovn-1348', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Tobramycin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Tobramycin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Tobramycin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tobramycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 7950, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tobramycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 7960, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tobramycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 7970, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tobramycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 7980, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Tobramycin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Tetracycline', '', 'Tetracycline', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Tetracycline', '', 'Tetracycline', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Tetracycline(Isolate)', 'Tetracycline', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1349', 3160, 'Tetracycline', '18993-6', 'ovn-1349', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Tetracycline' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Tetracycline' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Tetracycline(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tetracycline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8000, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tetracycline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8010, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tetracycline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8020, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Tetracycline(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8030, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Tetracycline(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Gentamicin 120', '', 'Gentamycine 120', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Gentamicin 120', '', 'Gentamycine 120', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Gentamycine 120(Isolate)', 'Gentamycine 120', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1350', 3170, 'Gentamycine 120', '18929-0', 'ovn-1350', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Gentamycine 120' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Gentamycine 120' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Gentamycine 120(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gentamycine 120(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8050, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gentamycine 120(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8060, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gentamycine 120(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8070, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Gentamycine 120(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8080, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Gentamycine 120(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ciprofloxacin', '', 'Ciprofloxacin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ciprofloxacin', '', 'Ciprofloxacin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ciprofloxacin(Isolate)', 'Ciprofloxacin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1351', 3180, 'Ciprofloxacin', '18906-8', 'ovn-1351', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ciprofloxacin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ciprofloxacin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ciprofloxacin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ciprofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8100, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ciprofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8110, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ciprofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8120, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ciprofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8130, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ciprofloxacin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Netilmicin', '', 'Netilmicin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Netilmicin', '', 'Netilmicin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Netilmicin(Isolate)', 'Netilmicin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1352', 3190, 'Netilmicin', '18954-8', 'ovn-1352', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Netilmicin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Netilmicin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Netilmicin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Netilmicin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8150, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Netilmicin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8160, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Netilmicin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8170, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Netilmicin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8180, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Netilmicin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Levofloxacin', '', 'Levofloxacin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Levofloxacin', '', 'Levofloxacin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Levofloxacin(Isolate)', 'Levofloxacin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1353', 3200, 'Levofloxacin', '20629-2', 'ovn-1353', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Levofloxacin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Levofloxacin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Levofloxacin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Levofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8200, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Levofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8210, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Levofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8220, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Levofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8230, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Levofloxacin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Norfloxacin', '', 'Norfloxacine', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Norfloxacin', '', 'Norfloxacine', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Norfloxacine(Isolate)', 'Norfloxacine', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1354', 3210, 'Norfloxacine', '18956-3', 'ovn-1354', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Norfloxacine' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Norfloxacine' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Norfloxacine(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Norfloxacine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8250, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Norfloxacine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8260, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Norfloxacine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8270, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Norfloxacine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8280, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Norfloxacine(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ofloxacin', '', 'Ofloxacin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ofloxacin', '', 'Ofloxacin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ofloxacin(Isolate)', 'Ofloxacin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1355', 3220, 'Ofloxacin', '18959-7', 'ovn-1355', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ofloxacin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ofloxacin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8300, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8310, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8320, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8330, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Nalidixic acid', '', 'Nalidixic Acid', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Nalidixic acid', '', 'Nalidixic Acid', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Nalidixic Acid(Isolate)', 'Nalidixic Acid', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1356', 3230, 'Nalidixic Acid', '18952-2', 'ovn-1356', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Nalidixic Acid' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Nalidixic Acid' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Nalidixic Acid(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nalidixic Acid(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8350, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nalidixic Acid(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8360, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nalidixic Acid(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8370, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nalidixic Acid(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8380, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Nalidixic Acid(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Trimethoprim+Sulfamethoxazole', '', 'Trimethoprime(sulfa)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Trimethoprim+Sulfamethoxazole', '', 'Trimethoprime(sulfa)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Trimethoprime(sulfa)(Isolate)', 'Trimethoprime(sulfa)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1357', 3240, 'Trimethoprime(sulfa)', '18998-5', 'ovn-1357', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Trimethoprime(sulfa)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Trimethoprime(sulfa)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Trimethoprime(sulfa)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Trimethoprime(sulfa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8400, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Trimethoprime(sulfa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8410, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Trimethoprime(sulfa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8420, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Trimethoprime(sulfa)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8430, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Trimethoprime(sulfa)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Chloramphenicol', '', 'Chloramphenicol', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Chloramphenicol', '', 'Chloramphenicol', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Chloramphenicol(Isolate)', 'Chloramphenicol', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1358', 3250, 'Chloramphenicol', '18903-5', 'ovn-1358', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Chloramphenicol' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Chloramphenicol' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Chloramphenicol(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Chloramphenicol(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8450, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Chloramphenicol(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8460, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Chloramphenicol(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8470, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Chloramphenicol(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8480, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Chloramphenicol(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Azithromycin', '', 'Azithromycin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Azithromycin', '', 'Azithromycin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Azithromycin(Isolate)', 'Azithromycin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1359', 3260, 'Azithromycin', '18866-4', 'ovn-1359', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Azithromycin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Azithromycin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Azithromycin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Azithromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8500, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Azithromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8510, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Azithromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8520, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Azithromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8530, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Azithromycin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Clarithromycin', '', 'Clarithromycin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Clarithromycin', '', 'Clarithromycin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Clarithromycin(Isolate)', 'Clarithromycin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1360', 3270, 'Clarithromycin', '18907-6', 'ovn-1360', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Clarithromycin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Clarithromycin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Clarithromycin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Clarithromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8550, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Clarithromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8560, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Clarithromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8570, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Clarithromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8580, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Clarithromycin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Erythromycin', '', 'Erythromycin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Erythromycin', '', 'Erythromycin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Erythromycin(Isolate)', 'Erythromycin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1361', 3280, 'Erythromycin', '18919-1', 'ovn-1361', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Erythromycin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Erythromycin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Erythromycin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Erythromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8600, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Erythromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8610, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Erythromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8620, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Erythromycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8630, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Erythromycin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Ofloxacin (Staphylococcus)', '', 'Ofloxacine(Staphylococci)', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Ofloxacin (Staphylococcus)', '', 'Ofloxacine(Staphylococci)', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Ofloxacine(Staphylococci)(Isolate)', 'Ofloxacine(Staphylococci)', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1362', 3290, 'Ofloxacine(Staphylococci)', '18959-7', 'ovn-1362', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Ofloxacine(Staphylococci)' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Ofloxacine(Staphylococci)' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacine(Staphylococci)(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacine(Staphylococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8650, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacine(Staphylococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8660, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacine(Staphylococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8670, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacine(Staphylococci)(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8680, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Ofloxacine(Staphylococci)(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Rifampicin', '', 'Rifampicine', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Rifampicin', '', 'Rifampicine', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Rifampicine(Isolate)', 'Rifampicine', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1363', 3300, 'Rifampicine', '18974-6', 'ovn-1363', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Rifampicine' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Rifampicine' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8700, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8710, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8720, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8730, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Rifampicine(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Polymyxin B', '', 'Polymycine B', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Polymyxin B', '', 'Polymycine B', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Polymycine B(Isolate)', 'Polymycine B', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1364', 3310, 'Polymycine B', '18972-0', 'ovn-1364', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Polymycine B' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Polymycine B' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Polymycine B(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Polymycine B(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8750, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Polymycine B(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8760, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Polymycine B(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8770, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Polymycine B(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8780, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Polymycine B(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Vancomycin', '', 'Vancomycin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Vancomycin', '', 'Vancomycin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Vancomycin(Isolate)', 'Vancomycin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1365', 3320, 'Vancomycin', '19000-9', 'ovn-1365', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Vancomycin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Vancomycin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Vancomycin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Vancomycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8800, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Vancomycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8810, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Vancomycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8820, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Vancomycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8830, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Vancomycin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Clindamycin', '', 'Clindamycin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Clindamycin', '', 'Clindamycin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Clindamycin(Isolate)', 'Clindamycin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1366', 3330, 'Clindamycin', '18908-4', 'ovn-1366', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Clindamycin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Clindamycin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Clindamycin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Clindamycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8850, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Clindamycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8860, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Clindamycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8870, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Clindamycin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8880, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Clindamycin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Nitrofurantoin', '', 'Nitrofurantoin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Nitrofurantoin', '', 'Nitrofurantoin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Nitrofurantoin(Isolate)', 'Nitrofurantoin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1367', 3340, 'Nitrofurantoin', '18955-5', 'ovn-1367', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Nitrofurantoin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Nitrofurantoin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Nitrofurantoin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nitrofurantoin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8900, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nitrofurantoin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8910, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nitrofurantoin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8920, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Nitrofurantoin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8930, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Nitrofurantoin(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Fosfomycin', '', 'Fosfomycine', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Fosfomycin', '', 'Fosfomycine', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Fosfomycine(Isolate)', 'Fosfomycine', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1368', 3350, 'Fosfomycine', '25596-8', 'ovn-1368', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Fosfomycine' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Fosfomycine' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Fosfomycine(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Fosfomycine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 8950, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Fosfomycine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 8960, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Fosfomycine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 8970, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Fosfomycine(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 8980, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Fosfomycine(Isolate)' ));
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test name', 'Colistin', '', 'Colistin', now() );
INSERT INTO clinlims.localization ( id, description, english, french, vietnamese, lastupdated ) VALUES
	( nextval( 'localization_seq' ), 'test report name', 'Colistin', '', 'Colistin', now() );
INSERT INTO clinlims.test ( id, uom_id, description, reporting_description, is_active, is_reportable, lastupdated, test_section_id, local_code, sort_order, name, loinc, guid, name_localization_id, reporting_name_localization_id ) VALUES
	( nextval( 'test_seq' ), NULL, 'Colistin(Isolate)', 'Colistin', 'Y', 'N', now(), ( SELECT id FROM clinlims.test_section WHERE name = 'Microbiology' ), 'ovn-1369', 3360, 'Colistin', '18912-6', 'ovn-1369', ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test name' AND vietnamese = 'Colistin' ), ( SELECT MAX(id) FROM clinlims.localization WHERE description = 'test report name' AND vietnamese = 'Colistin' ) );
INSERT INTO clinlims.sampletype_test ( id, sample_type_id, test_id ) VALUES
	( nextval( 'sample_type_test_seq' ), ( SELECT id FROM clinlims.type_of_sample WHERE description = 'Isolate' ), ( SELECT id FROM clinlims.test WHERE description = 'Colistin(Isolate)' ));
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Colistin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Nhạy' ), now(), 9000, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Colistin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Kháng' ), now(), 9010, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Colistin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Trung gian' ), now(), 9020, NULL, false);
INSERT INTO clinlims.test_result ( id, test_id, tst_rslt_type, value, lastupdated, sort_order, significant_digits, is_quantifiable ) VALUES
	( nextval( 'test_result_seq' ), ( SELECT id FROM clinlims.test WHERE description = 'Colistin(Isolate)' ), 'D', ( SELECT MAX(id) FROM clinlims.dictionary WHERE dict_entry = 'Không nhạy' ), now(), 9030, NULL, false);
INSERT INTO clinlims.panel_item ( id, panel_id, lastupdated, test_id ) VALUES
	( nextval( 'panel_item_seq' ), ( SELECT id FROM clinlims.panel WHERE name = 'Antibiotics map' ), now(), ( SELECT id FROM clinlims.test WHERE description = 'Colistin(Isolate)' ));

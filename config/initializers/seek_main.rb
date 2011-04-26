#DO NOT EDIT THIS FILE.
#TO MODIFY THE DEFAULT SETTINGS, COPY seek_local.rb.pre to seek_local.rb AND EDIT THAT FILE INSTEAD

require 'authorization'
require 'save_without_timestamping'
require 'asset'
require 'calendar_date_select'
require 'active_record_extensions'
require 'acts_as_taggable_extensions'
require 'acts_as_isa'
require 'acts_as_yellow_pages'
require 'seek/acts_as_uniquely_identifiable'
require 'acts_as_favouritable'
require 'object'

GLOBAL_PASSPHRASE="ohx0ipuk2baiXah" unless defined? GLOBAL_PASSPHRASE

ASSET_ORDER                = ['Person', 'Project', 'Institution', 'Investigation', 'Study', 'Assay', 'Experiment','Sample','Specimen','DataFile', 'Model', 'Sop', 'Publication', 'SavedSearch', 'Organism', 'Event']

PORTER_SECRET = "" unless defined? PORTER_SECRET

Seek::Config.propagate_all

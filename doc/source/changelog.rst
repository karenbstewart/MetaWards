=========
Changelog
=========

`1.1.0 <https://github.com/metawards/MetaWards/compare/1.0.0...1.1.0>`__ - June 11th 2020
------------------------------------------------------------------------------------------

* Different demographics can now follow different disease pathways. This
  supports modelling of super-spreaders and hospitals, as described
  in :doc:`part 7 of the tutorial <tutorial/index_part07>`.
* Variables in demographic sub-networks can be scanned independently from
  the overal network or other sub-networks. This means you can, e.g.
  enact lock-downs in specific demographics, or scan disease parameters
  for different demographics.
* Added a :meth:`~metawards.movers.go_stage` function that moves individuals
  from and to specific disease stages in different demographics. This is
  used to support conditional branching, e.g. 20% of I2 infecteds go to
  hospital.
* Added "--star-as-E", "--star-as-R" and "--disable-star" command line
  arguments to control how the "*" state is counted in the summary outputs.
  This enables it to be counted as an extra "E" state, which makes the
  output more meaningful and more easily interpretable.
* Clarified the meaning the "day 0" and "day 1". Now "day 0" is before
  the model run starts (i.e. setup). The first iteration of the model
  run is "day 1". This is a change from previous versions, which called
  the first half of the first iteration "day 0" and the second half "day 1".
  Since seeding happens in the first half, this means that we now seed one
  day earlier than previous versions, so outbreaks are now one day ahead.
* Fixed a major bug in calculation of the demographic sub-networks
  denominators. These have not been used in production yet. If you
  are going to use demographic sub-networks then please make sure
  you use this version (1.1.0) or above.
* Added database support to :class:`~metawards.OutputFiles`, so that you
  can now write data to SQLite3 databases. This is described in a new
  part of :doc:`tutorial chapter 4 <tutorial/part04/04_rates>`.
* Added in extra output to :class:`~metawards.Workspace` so that you can
  get the populations of all disease stages for all demographics. This
  is demonstrated in a rate calculation, also in the
  :doc:`new tutorial chapter 4 <tutorial/part04/04_rates>`.
* Fixed a directory permissions bug that appeared sometimes on windows.
* Fixed an existing bug from the C code whereby user-set values of
  contrib_foi are ignored. This had no impact as these values are always 1.0.
* Fixed a bug in distribute_remainders that meant that individuals could
  sometimes still be added to a demographic even if the desired percentage
  was zero.

`1.0.0 <https://github.com/metawards/MetaWards/compare/0.12.0...1.0.0>`__ - May 23rd 2020
-----------------------------------------------------------------------------------------

* Improved "go_to" and "go_isolate" functions, which now support modelling
  self-isolation and quarantine. This is all demonstrated in a new
  part 6 of the tutorial.
* Added an InteractionMatrix class to make it easier to create more
  sophisticated interaction matricies.
* Added ability for any plugin to signal that the model run should end
  after the current iteration by raising a StopIteration exception
* Added a "--model single" mode that uses a single-ward model for
  debugging and validation purposes.
* Updated parallel runners (multiprocessing, scoop and MPI) to return
  results as they are available, so that the Console can report summaries
  and live progress.
* Added a developer's "debug" mode to the Console, complete with nice
  variable printing.
* Lots of file and text encoding fixes, particularly to fix unicode
  issues on windows.
* Finally fixed the issue on windows where the wrong plugin would
  sometimes be loaded.
* Updated all tutorial outputs to the new format.
* Fixed a runtime check exception that occurred on rare occasions on Windows.
  This didn't cause any errors in data, but did stop runs from continuing
  when the run-time test was failed.


`0.12.0 <https://github.com/metawards/MetaWards/compare/0.11.2...0.12.0>`__ - May 18th 2020
--------------------------------------------------------------------------------------------

* Switched to configargparse to have better management of command line options,
  plus adding the ability to set options using a config file. This is now
  written to the output directory of each job to support reproducibility.
* metawards-plot defaults to png output if pillow (and jpeg) are not available
* Got basic movers working and added half of the sixth part of the tutorial,
  where self-isolation is modelled.
* Added rich-console support, which has significantly altered the look and
  feel of metawards. Output is now more robust, with more info given in
  real time for parallel jobs, plus all output now also being recorded
  to output/console.txt.bz2, so that no output is lost.
* Added theming support and a "simple" theme activated using "--theme simple"
  for those that don't like colour ;-)
* Added support for setting the number of repeats for a VariableSet into
  the output file. Also can specify different number of repeats for different
  adjustable variable sets on the command line.
* Cleaned up the design file and user custom variable file parsing to use
  csv and support a wide range of formats, variable types and inputs.
  Can now directly work with dates, ints, floats, bools and strings. This
  is intelligent, and will use the best type it thinks, but it can be
  forced by the user via a d"3.4" numpy-type syntax
* Improved the robustness of the parallel runners (multiprocessing, scoop
  and mpi4py) such that errors in one job don't break all jobs. These are
  now handled individually and recorded properly. Jobs are run async so
  that results are processed and feedback is given to the user as soon
  as it is available.
* Updated all of the tutorial to use lurgy3 - accidentally had gone back
  to lurgy2 in part 5.

`0.11.2 <https://github.com/metawards/MetaWards/compare/0.11.1...0.11.2>`__ - May 11th 2020
--------------------------------------------------------------------------------------------

* Minor bugfixes
* Use last matching custom function rather than first, so
  that the examples in the tutorial work and behaviour is more natural
* Caching network builds so that they are more thoroughly tested, fixed
  bug in networks.copy that meant that independent copies weren't made.
  This bug did not impact any past results or runs.
* Added more validation tests of the mixers
* Cleaned up website typos and fixed the version switcher
* Fixed packaging problems that caused broken builds when pip installing
  from a .tgz sdist package.

`0.11.1 <https://github.com/metawards/MetaWards/compare/0.11.0...0.11.1>`__ - May 10th 2020
--------------------------------------------------------------------------------------------

* Fixed CI/CD to produce working sdist and bdist packages

`0.11.0 <https://github.com/metawards/MetaWards/compare/0.10.0...0.11.0>`__ - May 10th 2020
--------------------------------------------------------------------------------------------

* Code now fully works and has been tested on Windows :-)
* Major update of the API to support a Networks of multiple Network objects
* This has been used to support modelling multiple demographics
* Added in movers and mixers to enable a user to customise how individuals
  are moved between demographics and how the FOIs of demographics are
  merged together (e.g. via an interaction matrix). This is demonstrated
  in part 5 of the tutorial which shows how this can be used to model
  shielding
* Allow compilation using compilers that don't support OpenMP - now compiles
  even on stock OS X.
* Added more extractors and can now output files that are needed for graphics
* Added a special random number seed to support debugging
* Moved random number files to a separate library which is now properly
  compiled and linked.
* Updated CI to CI/CD and now build the OS X, Windows and ManyLinux wheels
* Updated URLs to metawards.org
* Allow multiple multi-node jobs to run from a single directory (they now
  have their own hostfiles)
* Updated metawards-plot to render multi-demographic trajectories and
  to make better animations.
* General bug fixes and speed-ups :-)

`0.10.0 <https://github.com/metawards/MetaWards/compare/0.9.0...0.10.0>`__ - April 27th 2020
--------------------------------------------------------------------------------------------

* Created all of the extract framework to support customising the output
  and analysis during a run.
* Created a better Workspace class for holding accumulated data during extract
* Completed most of the extractor tutorial
* Added in WardInfo(s) to get metadata about wards, and to support searching
  for wards via their name, code, authority and region

`0.9.0 <https://github.com/metawards/MetaWards/compare/0.8.4...0.9.0>`__ - April 24th 2020
------------------------------------------------------------------------------------------

* Merged in latest changes from the C code. Now gives complete agreement,
  including via a custom iterator that repeats the lockdown model.
* Support x/y and lat/lon coordinates and distances. Now works properly
  with the 2011UK model data
* Added an example of a lockdown parameter set scan

`0.8.5 <https://github.com/metawards/MetaWards/compare/0.8.3...0.8.5>`__ - April 22nd 2020
------------------------------------------------------------------------------------------

* Small bugfixes to support the loading of the 2011UK model data
* Cleaned up the website and added the version combo box

`0.8.3 <https://github.com/metawards/MetaWards/compare/0.8.0...0.8.3>`__ - April 21st 2020
------------------------------------------------------------------------------------------

* Fixing CI/CD so that I can build and deploy on a new tag (hopefully 0.8.2)

`0.8.0 <https://github.com/metawards/MetaWards/compare/0.7.0...0.8.0>`__ - April 21st 2020
------------------------------------------------------------------------------------------

* Automated github actions for building a versioned website plus automating
  building the packages.
* Switched default for UV parameter to 0.0, as this should not normally be 1.0
* Added custom user variables both for scanning and to act as inputs that
  may be used by custom advance and iterate functions. Detailed tutorial
  now shows how these can be used to model a lockdown.
* Improved speed of custom iterators

`0.7.1 <https://github.com/metawards/MetaWards/compare/0.6.0...0.7.1>`__ - April 17th 2020
------------------------------------------------------------------------------------------

* Small bugfixes to support all of the examples in part 3 of the tutorial

`0.7.0 <https://github.com/metawards/MetaWards/compare/0.6.0...0.7.0>`__ - April 17th 2020
------------------------------------------------------------------------------------------

* Lots of progress with the project website, including a detailed tutorial
* Support fully customisable disease models, and can adjust any disease
  parameter using a more flexible input file format
* Can record the date in a model run, plus set the starting day and date
* Broken up the iterate function into :mod:`metawards.iterators`, and
  can now have the user create their own custom iterators. Tutorial on
  how to do this will appear soon.
* Broken up the extract_data function into :mod:`metawards.extractors`,
  and will soon enable a user to create their own. Tutorial on how
  to do this will appear soon.
* Added metawards-plot to create simple plots and animations. This is
  particularly useful when working through the tutorial.
* General code cleaning, documentation improvements and nice-to-haves
  that make the code easier to use.

`0.6.0 <https://github.com/metawards/MetaWards/compare/0.5.0...0.6.0>`__ - April 9th 2020
-----------------------------------------------------------------------------------------

* Wrote an initial draft of the complete project website
* Fixed packaging problems that prevented installation of older packages
  on some systems

`0.5.0 <https://github.com/metawards/MetaWards/compare/0.4.0...0.5.0>`__ - April 8th 2020
-----------------------------------------------------------------------------------------

* Support running multiple model runs in serial or in parallel
* Support aggregation and writing of model multiple model run outputs
  to the same directory, including to a single shared CSV data file.
* Support for parallel running via multiprocessing, mpi4py or scoop

`0.4.0 <https://github.com/metawards/MetaWards/compare/0.3.1...0.4.0>`__ - April 7th 2020
-----------------------------------------------------------------------------------------

* Parallelisation of individual model runs using OpenMP
* Parallel code scales to large numbers of cores and can complete individual
  runs in 10-15 seconds.

`0.3.1 <https://github.com/metawards/MetaWards/compare/0.3.0...0.3.1>`__ - April 5th 2020
-----------------------------------------------------------------------------------------

* Minor bug fixes in packaging and misplaced commits caused by move of
  repository

`0.3.0 <https://github.com/metawards/MetaWards/compare/v0.2.0...0.3.0>`__ - April 5th 2020
------------------------------------------------------------------------------------------

* Adding in a simple profiler to support optimisation of the code
* Replaced GSL random number generator with a more liberally licensed and
  easily bundled generator extracted from numpy.
* Switched code to the https://github.com/metawards organisation
* Optimised more using cython and raw C for file reading
* Added automatic versioning of packages and files using versioneer
* Cleaned up the repository and added status badges

`0.2.0 <https://github.com/metawards/MetaWards/compare/v0.1.0...v0.2.0>`__ - March 31st 2020
--------------------------------------------------------------------------------------------

* Cythonizing the bottleneck code to bring the python code up to a comparable
  performance as the original C code.
* Added in packaging information and general repository and file cleaning.

`0.1.0 <https://github.com/metawards/MetaWards/releases/tag/v0.1.0>`__ - March 29th 2020
----------------------------------------------------------------------------------------

* Fully working Python port of the original C code that completely reproduces
  the results of the C code when given the same random number seed. However,
  it is *significantly* slower! Python port has promise, so worth exploring
  different options for speeding the code up.

`Start of the Python port <https://github.com/metawards/MetaWards/commit/ef989ece450c40fe0ddb9f22e21693c90afb432e>`__ - March 25th 2020
---------------------------------------------------------------------------------------------------------------------------------------

* Imported code from https://github.com/ldanon/metawards and began thinking
  about what the code was and trying to understand it. Decided to write
  a port as I find that if I can translate something, then I can
  understand it.

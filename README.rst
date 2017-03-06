.. image:: https://travis-ci.com/elucideye/drishti-upload.svg?token=N3Qyq7GstHwgyhruE55K&branch=master
  :target: https://travis-ci.com/elucideye/drishti-upload/builds

.. image:: https://ci.appveyor.com/api/projects/status/ek088rc7pw58m5l3/branch/master?svg=true
  :target: https://ci.appveyor.com/project/elucideye/drishti-upload

Usage:

1. Update third parties configuration
2. Push to GitHub
3. Go to Travis and **cancel** all jobs
4. Restart jobs with ``LEVEL=1``
5. When ``LEVEL=1`` done restart jobs with ``LEVEL=2``
6. When ``LEVEL=2`` done restart jobs with ``LEVEL=3``

Links:

* `AppVeyor builds <https://ci.appveyor.com/project/elucideye/drishti-upload/history>`__
* `Uploaded assets <https://github.com/elucideye/hunter-cache/releases/tag/cache>`__

Note
~~~~

Android build of Boost.iostreams is broken if host is Linux so such job can fail with "broken package" error message (see https://github.com/ruslo/hunter/issues/417#issuecomment-220563231). The workaround to this problem is to build Boost.iostreams on OSX host and upload it. tl;dr ignore failed status, wait for OSX to upload and restart Linux job again.

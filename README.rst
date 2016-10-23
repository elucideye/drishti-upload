.. image:: https://travis-ci.com/elucideye/drishti-upload.svg?token=N3Qyq7GstHwgyhruE55K&branch=master
  :target: https://travis-ci.com/elucideye/drishti-upload/builds

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

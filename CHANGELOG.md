# Changelog
All notable changes to this project will be documented in this file.

## [Unreleased]

### Changed
- Disable all links during reload process.

## [2.8.0] - 2018-01-03
### Added
- `OOD_SHOW_JOB_OPTIONS_ACCOUNT_FIELD` env var can be set to a falsy value (i.e. `OOD_SHOW_JOB_OPTIONS_ACCOUNT_FIELD=0`) which allows hiding account field from job options
- Loads /etc/ood/config/apps/myjobs/env file as dotenv file when in production environment. Can change location of this by setting `OOD_APP_CONFIG_ROOT` in .env.local. This allows moving app specific environment configuration to /etc/, easing installing and updating the dashboard app.
- /etc/ood/config/apps/myjobs/initializers and /etc/ood/config/apps/myjobs/views now are optional paths to place custom initializer and view and view partial overrides

### Fixed
- Create directory containing sqlite3 database prior to creating sqlite3 database [#197](https://github.com/OSC/ood-myjobs/issues/197)

### Changed
- Load dotenv files in two passes: .env.local files first, then the rest of the dotenv files. This allows overriding `OOD_APP_CONFIG_ROOT` in .env.local which is useful for testing configuration changes when doing development.
- Configuration object is now created in config/boot so it can be used in setup scripts and rake tasks that don't load the config/application.
- Removed `therubyracer` gem requirement in favor of node.js.


## [2.7.0] - 2017-11-27
### Changed
- Updated from Rails 4.1 to Rails 4.2.10.
  [#250](https://github.com/OSC/ood-myjobs/issues/250)

## [2.6.2] - 2017-11-17
### Fixed
- Fix bug when copying job from existing. [#245](https://github.com/OSC/ood-myjobs/issues/245)

## [2.6.1] - 2017-10-20
### Changed
- Updated `ood_core` library which includes bug fixes and new Batch Connect
  helper functions for scripts.
  [#241](https://github.com/OSC/ood-myjobs/pull/241)

## [2.6.0] - 2017-09-27
### Fixed
- Joyride help fixed to work with new button dropdwon for creating jobs:
  https://github.com/OSC/ood-myjobs/issues/236

### Changed
- Rename app to "Job Composer" because "MyJobs" is a confusing name:
  https://github.com/OSC/ood-myjobs/issues/238

## [2.5.2] - 2017-09-08
### Fixed
- update dependencies to fix bug with LSF (see https://github.com/OSC/ood_core/pull/50)

## [2.5.1] - 2017-09-06
### Fixed
- Sanitize user input for account string.
  [#233](https://github.com/OSC/ood-myjobs/issues/233)

## [2.5.0] - 2017-07-12
### Added
- Support for PBS Pro and basic support for LSF 9.1 via update to ood_core gem

## [2.4.2] - 2017-07-10
### Added
- Add warning and prevent submission if host is invalid

### Changed
- Display a cluster's metadata title instead of titleized id
- Fix bug where new template path isn't blank
- Redirect user to new templates page on cancel
- Fix a bug when requesting data for a workflow with an unassigned batch_host

## [2.4.1] - 2017-06-05
- Fix bug in `bin/setup` that crashes when `OOD_PORTAL` is set but not
  `OOD_SITE`

## [2.4.0] - 2017-05-26
- Allow user to enter relative path names as template source
- Allow a user to create a new workflow from a path
- Allow user to resubmit a completed/failed job
- Display the script name associated with a workflow
- Add prompt to null selectpicker option
- Wrap long names that break out of containers
- UI enhancements

## [2.3.4] - 2017-05-15
- Terminal button now links to appropriate host instead of default
- Update to OOD Appkit 1.0.1
- Alert if no valid hosts are available
- Hide row of job creation buttons if no submit hosts
- UI enhancements


[Unreleased]: https://github.com/OSC/ood-myjobs/compare/v2.8.0...HEAD
[2.8.0]: https://github.com/OSC/ood-myjobs/compare/v2.7.0...v2.8.0
[2.7.0]: https://github.com/OSC/ood-myjobs/compare/v2.6.2...v2.7.0
[2.6.2]: https://github.com/OSC/ood-myjobs/compare/v2.6.1...v2.6.2
[2.6.1]: https://github.com/OSC/ood-myjobs/compare/v2.6.0...v2.6.1
[2.6.0]: https://github.com/OSC/ood-myjobs/compare/v2.5.2...v2.6.0
[2.5.2]: https://github.com/OSC/ood-myjobs/compare/v2.5.1...v2.5.2
[2.5.1]: https://github.com/OSC/ood-myjobs/compare/v2.5.0...v2.5.1
[2.5.0]: https://github.com/OSC/ood-myjobs/compare/v2.4.2...v2.5.0
[2.4.2]: https://github.com/OSC/ood-myjobs/compare/v2.4.1...v2.4.2
[2.4.1]: https://github.com/OSC/ood-myjobs/compare/v2.4.0...v2.4.1
[2.4.0]: https://github.com/OSC/ood-myjobs/compare/v2.3.4...v2.4.0
[2.3.4]: https://github.com/OSC/ood-myjobs/compare/v1.0.0...v2.3.4

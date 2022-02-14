"""Use testinfra and py.test to verify formula works properly"""

def test_package_in_installed(Package):
    saltmaster = Package('salt-master')
    assert saltmaster.is_installed

def test_service_is_enabled(Service):
    saltmaster = Service('salt-master')
    assert saltmaster.is_enabled

def test_service_is_running(Service):
    saltmaster = Service('salt-master')
    assert saltmaster.is_running


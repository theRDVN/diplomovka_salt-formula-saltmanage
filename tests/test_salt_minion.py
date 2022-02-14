"""Use testinfra and py.test to verify formula works properly"""

def test_package_in_installed(Package):
    saltminion = Package('salt-minion')
    assert saltminion.is_installed

def test_service_is_enabled(Service):
    saltminion = Service('salt-minion')
    assert saltminion.is_enabled

def test_service_is_running(Service):
    saltminion = Service('salt-minion')
    assert saltminion.is_running


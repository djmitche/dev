# By default, no sources
SOURCES=""

# A default load_sources which simply calls base_load_sources, defined in
# extensions/base/load.  Tasks can override this to do complex initialization
load_sources() {
    base_load_sources
}

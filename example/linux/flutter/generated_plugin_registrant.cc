//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <device_region/device_region_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) device_region_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DeviceRegionPlugin");
  device_region_plugin_register_with_registrar(device_region_registrar);
}

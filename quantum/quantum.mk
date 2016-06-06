QUANTUM_DIR = quantum

QUANTUM_PATH = $(TOP_DIR)/$(QUANTUM_DIR)

ifndef VERBOSE
.SILENT:
endif

# # project specific files
SRC += quantum.c \
	keymap_common.c \
	led.c

# ifdef KEYMAP_FILE
# ifneq (,$(shell grep USING_MIDI '$(KEYMAP_FILE)'))
# MIDI_ENABLE=yes
# $(info  * Overriding MIDI_ENABLE setting - $(KEYMAP_FILE) requires it)
# endif
# ifneq (,$(shell grep USING_UNICODE '$(KEYMAP_FILE)'))
# UNICODE_ENABLE=yes
# $(info  * Overriding UNICODE_ENABLE setting - $(KEYMAP_FILE) requires it)
# endif
# ifneq (,$(shell grep USING_BACKLIGHT '$(KEYMAP_FILE)'))
# BACKLIGHT_ENABLE=yes
# $(info  * Overriding BACKLIGHT_ENABLE setting - $(KEYMAP_FILE) requires it)
# endif
# endif

ifndef CUSTOM_MATRIX
	SRC += $(QUANTUM_DIR)/matrix.c
endif

#ifeq ($(strip $(MIDI_ENABLE)), yes)
#	SRC += $(QUANTUM_DIR)/keymap_midi.c
#endif

ifeq ($(strip $(AUDIO_ENABLE)), yes)
    SRC += $(QUANTUM_DIR)/audio/audio.c
    SRC += $(QUANTUM_DIR)/audio/voices.c
    SRC += $(QUANTUM_DIR)/audio/luts.c
endif

ifeq ($(strip $(RGBLIGHT_ENABLE)), yes)
	SRC += $(QUANTUM_DIR)/light_ws2812.c
	SRC += $(QUANTUM_DIR)/rgblight.c
	OPT_DEFS += -DRGBLIGHT_ENABLE
endif

# Optimize size but this may cause error "relocation truncated to fit"
#EXTRALDFLAGS = -Wl,--relax

# Search Path
VPATH += $(QUANTUM_PATH)
VPATH += $(QUANTUM_PATH)/keymap_extras
VPATH += $(QUANTUM_PATH)/audio


include $(TMK_DIR)/protocol/lufa.mk
include $(TMK_DIR)/common.mk
include $(TMK_DIR)/rules.mk

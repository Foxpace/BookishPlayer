#include "cactus_engine.h"

extern "C" {

CACTUS_FFI_EXPORT cactus_model_t bookish_cactus_init(
    const char* model_path,
    const char* corpus_dir,
    bool cache_index) {
    return cactus_init(model_path, corpus_dir, cache_index);
}

CACTUS_FFI_EXPORT void bookish_cactus_destroy(cactus_model_t model) {
    cactus_destroy(model);
}

CACTUS_FFI_EXPORT int bookish_cactus_transcribe(
    cactus_model_t model,
    const char* audio_file_path,
    const char* prompt,
    char* response_buffer,
    size_t buffer_size,
    const char* options_json,
    cactus_token_callback callback,
    void* user_data,
    const uint8_t* pcm_buffer,
    size_t pcm_buffer_size) {
    return cactus_transcribe(
        model,
        audio_file_path,
        prompt,
        response_buffer,
        buffer_size,
        options_json,
        callback,
        user_data,
        pcm_buffer,
        pcm_buffer_size);
}

CACTUS_FFI_EXPORT const char* bookish_cactus_get_last_error() {
    return cactus_get_last_error();
}

}

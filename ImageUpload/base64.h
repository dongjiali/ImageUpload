size_t EstimateBas64EncodedDataSize(size_t inDataSize);
size_t EstimateBas64DecodedDataSize(size_t inDataSize);

bool Base64EncodeData(const void *inInputData, size_t inInputDataSize, char *outOutputData, size_t *ioOutputDataSize, BOOL wrapped);
bool Base64DecodeData(const void *inInputData, size_t inInputDataSize, void *ioOutputData, size_t *ioOutputDataSize);
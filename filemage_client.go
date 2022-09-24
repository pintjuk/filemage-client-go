package filemage_client_go

type endpointCrudClient struct {
}

type apiClient struct {
	// Add whatever fields, client or connection info, etc. here
	// you would need to setup to communicate with the upstream
	// API.
	api_key string
	host    string
}

func NewClient(api_key string, host string) apiClient {
	return apiClient{api_key, host}
}

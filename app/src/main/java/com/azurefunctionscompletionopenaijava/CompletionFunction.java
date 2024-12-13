package com.azurefunctionscompletionopenaijava;

import com.microsoft.azure.functions.ExecutionContext;
import com.microsoft.azure.functions.HttpMethod;
import com.microsoft.azure.functions.HttpRequestMessage;
import com.microsoft.azure.functions.HttpResponseMessage;
import com.microsoft.azure.functions.HttpStatus;
import com.microsoft.azure.functions.annotation.AuthorizationLevel;
import com.microsoft.azure.functions.annotation.FunctionName;
import com.microsoft.azure.functions.annotation.HttpTrigger;
import com.microsoft.azure.functions.openai.annotation.textcompletion.TextCompletion;
import com.microsoft.azure.functions.openai.annotation.textcompletion.TextCompletionResponse;

public class CompletionFunction {
    @FunctionName("PostUserContent")
    public HttpResponseMessage postUserContent(
        @HttpTrigger(name = "req", methods = {HttpMethod.POST}, authLevel = AuthorizationLevel.FUNCTION) HttpRequestMessage<String> request,
        @TextCompletion(name = "content", model = "%CHAT_MODEL_DEPLOYMENT_NAME%", prompt = "{content}") TextCompletionResponse response,
        final ExecutionContext context) {

        context.getLogger().info("Java HTTP trigger processed a request.");

        if (response == null || response.getContent() == null) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Failed to get completion response").build();
        }

        return request.createResponseBuilder(HttpStatus.OK).body(response.getContent()).build();
    }
}

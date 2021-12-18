class APIResponse<T> {
  late Status status;
  late T data;
  late String message = '';

  APIResponse.loading(this.message) : status = Status.LOADING;
  APIResponse.completed(this.data) : status = Status.COMPLETED;
  APIResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }

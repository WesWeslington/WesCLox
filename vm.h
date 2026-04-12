#ifndef clox_vm_h
#define clox_vm_h

#include "chunk.h"
#include "value.h"

#define STACK_MAX 256

typedef struct{
  Chunk* chunk;
  uint8_t* ip;
  Value stack[STACK_MAX];
  Value* stackTop;
} VM;


typedef enum {
  INTERPRET_OK,
  INTERPRET_COMPILE_ERROR,
  INTERPRET_RUNTIME_ERROR
} InterpretResult;

void initVM();
void freeVM();
InterpretResult interpret(Chunk* chunk);
void push(Value value);
Value pop();


#endif

// 10,000X
// me:   08:40:58 - 08:41:02 ~(4s)
// book: 08:40:01 - 08:40:12 ~(11s)

// 100,000x
// me:  08:41:58 - 08:42:01 ~(3s)
// book: 08:43:37 - 08:43:41

# Stream unmodified, compressed logs and do processing at server side to save bandwidth
import socket

host="10.0.0.1"
port=1243

def lambda_handler(event, context):
    
  sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

  try:
      sock.connect((host, port))
      sock.send(str(event["awslogs"]["data"]))
  finally:
      sock.close()

  return {
    }

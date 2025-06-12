import os
from dotenv import load_dotenv
from openai import OpenAI
from openai.resources.fine_tuning import FineTuning
from openai.types.fine_tuning import FineTuningJob


class FineTuner:
    client: OpenAI
    data_file_name: str
    data_file_id: str
    tuning_job: FineTuningJob


    def __init__(self, data_file_name='data.jsonl'):
        os.chdir('../..')
        load_dotenv()

        self.client = OpenAI(api_key=os.environ['OPENAI_API_KEY'])
        self.data_file_name = data_file_name
        os.chdir(os.path.dirname(__file__))


    def register_data(self, data_file_name='data.jsonl') ->str:
        print(f'registering data file: {data_file_name} ...')
        responce = self.client.files.create(
            file=open(self.data_file_name, 'rb'),
            purpose='fine-tune'
        )
        print(f'...registed data file: {responce.id}')

        self.data_file_id = responce.id
        return self.data_file_id


    def run_tuning(self) ->str:
        responce = self.client.fine_tuning.jobs.create(
            training_file=self.data_file_id,
            model='gpt-3.5-turbo'
        )
        print(f'Tuning ID: {responce.id}')
        self.tuning_job = responce
        return responce.id


    def cancel_tuning(self, job_id=''):
        if job_id == '':
            job_id = self.tuning_job.id
        responce = self.client.fine_tuning.jobs.cancel(job_id)
        print('Succeeded in cancelling the job.')


    def check_tuning_status(self, job_id=''):
        if job_id == '':
            job_id = self.tuning_job.id
        responce = self.client.fine_tuning.jobs.retrieve(job_id)
        print( "Status:", responce.status )
        print( "Fine Tuned Model ID: ", responce.fine_tuned_model )
    

    def get_tuned_model(self) ->str:
        model = self.tuning_job.fine_tuned_model
        print(f'Model: {model}')
        return str(model)

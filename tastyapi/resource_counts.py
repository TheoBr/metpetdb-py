from django.db import transaction
import dotenv
dotenv.read_dotenv('../../env_variables.env')
from tastyapi.models import Sample, Subsample, ChemicalAnalyses, Image

@transaction.atomic
def main():
    for sample in Sample.objects.all():
        sample.subsample_count = sample.subsamples.all().count()
        sample.image_count = sample.images.all().count()

        count = 0
        for subsample in sample.subsamples.all():
            count += subsample.chemical_analyses.all().count()

        sample.chem_analyses_count = count
        sample.save()

    for subsample in Subsample.objects.all():
        subsample.image_count = subsample.images.all().count()
        subsample.chem_analyses_count = subsample.chemical_analyses.all().count()
        subsample.save()


if __name__ == "__main__":
    main()
